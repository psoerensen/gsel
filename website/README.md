# Local documentation website

Adapted from gsim: authoritative README/scientific Markdown and generated Rd,
Flatly/MathJax/GitHub highlighting, and ignored website/_site output rather
than rendering into docs. No package loading, example execution, biological
download or package installation occurs. No deployment workflow or invented
public package URL is included.

```sh
python website/build.py --rscript /path/to/Rscript --quarto /path/to/quarto
```

Tools default to PATH. Python 3, base R and Quarto are developer tools only.
The helper converts package help via tools::Rd2HTML, maps internal links, and
copies the tiny reference/notices for local download. --prepare-only skips
rendering. Edit authority, never generated QMD/HTML. No teaching or private
repository is read. Publication requires a separate explicit instruction.

The homepage is website/_site/generated/index.html (also linked by Quarto navigation).
After editing only the verification record, use --page docs-qualification-foundations.qmd.
