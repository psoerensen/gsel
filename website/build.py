"""Local static preview only; never load the package or execute examples."""
from pathlib import Path
import argparse, json, os, posixpath, re, shutil, subprocess
SITE = Path(__file__).resolve().parent
ROOT = SITE.parent

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--rscript", default=shutil.which("Rscript"))
    parser.add_argument("--quarto", default=shutil.which("quarto"))
    parser.add_argument("--prepare-only", action="store_true")
    parser.add_argument("--page", choices=["docs-qualification-foundations.qmd", "reference.qmd"], help="Refresh one generated page")
    args = parser.parse_args()
    if not args.rscript or (not args.quarto and not args.prepare_only):
        parser.error("Supply installed tool paths; no installation is attempted")
    generated = SITE / "generated"
    generated.mkdir(exist_ok=True)
    files = [ROOT / "README.md", *sorted((ROOT / "docs").rglob("*.md"))]
    mapping = {p.relative_to(ROOT).as_posix():
               ("index.qmd" if p == ROOT / "README.md" else
                p.relative_to(ROOT).with_suffix("").as_posix().replace("/", "-") + ".qmd") for p in files}
    mapping["website/README.md"] = "website-guide.qmd"
    files.append(ROOT / "website/README.md")
    downloads = {"inst/COPYRIGHTS": "files/COPYRIGHTS", "inst/examples/reference.R": "files/reference.R"}
    for original, target in downloads.items():
        destination = generated / target
        destination.parent.mkdir(exist_ok=True)
        shutil.copyfile(ROOT / original, destination)
    mapping.update(downloads)
    def adapt(text, source):
        def link(match):
            dest = match[2]
            if re.match(r"[a-z]+:", dest) or dest.startswith("#"):
                return match[0]
            path, sep, anchor = dest.partition("#")
            resolved = posixpath.normpath(posixpath.join(posixpath.dirname(source), path))
            if resolved not in mapping:
                raise ValueError("Unmapped documentation link: " + resolved)
            return "[" + match[1] + "](" + mapping[resolved] + sep + anchor + ")"
        return re.sub(r"\[([^\]]+)\]\(([^\s)]+)\)", link, text)
    for p in files:
        source = p.relative_to(ROOT).as_posix()
        text = adapt(p.read_text(encoding="utf-8"), source)
        title = text.splitlines()[0].lstrip("# ")
        (generated / mapping[source]).write_text("---\ntitle: " + json.dumps(title) + "\n---\n\n" + text, encoding="utf-8")
    rd = next((ROOT / "man").glob("*-package.Rd"))
    # Use full Rd conversion as in gsim, then retain only its HTML body.
    code = 'a <- commandArgs(TRUE); tools::Rd2HTML(tools::parse_Rd(a[1]), out=a[2], fragment=FALSE, outputEncoding="UTF-8")'
    subprocess.run([args.rscript, "--vanilla", "-e", code, str(rd), str(generated / "reference-body.txt")], check=True)
    html = (generated / "reference-body.txt").read_text(encoding="utf-8")
    body = html.split("<body>", 1)[1].split("</body>", 1)[0]
    body = re.sub(r"</?main[^>]*>", "", body)
    body = body.replace('href="00Index.html"', 'href="index.html"')
    (generated / "reference.qmd").write_text('---\ntitle: "Package reference"\n---\n\nNo scientific functions are exported.\n\n```{=html}\n' + body + '\n```\n', encoding="utf-8")
    if not args.prepare_only:
        env = os.environ.copy()
        cache = SITE / ".cache"
        cache.mkdir(exist_ok=True)
        env["LOCALAPPDATA" if os.name == "nt" else "XDG_CACHE_HOME"] = str(cache)
        target = SITE / "generated" / args.page if args.page else SITE
        subprocess.run([args.quarto, "render", str(target), "--no-execute"], cwd=ROOT, env=env, check=True)
if __name__ == "__main__":
    main()
