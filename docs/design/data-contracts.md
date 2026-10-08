# Proposed data and package cooperation

These are proposals for future interfaces; no validator or new class is exported.

| Item | Convention |
| --- | --- |
| Individuals and parents | Character animal/sire/dam as in gsim; unique nonempty animal IDs, missing parents NA, never sentinel 0. Known parents resolve; reject cycles/self-parentage. Glist ids map explicitly to animal labels. Row numbers are not identities. |
| Populations and cohorts | Explicit population/cohort labels. Generation, age, birth date and calendar time are different quantities. Preserve supplied ordering and labels. gsim pedigree cohort/generation are positive integers; external labels need an explicit mapping, not a silent type conversion. |
| Traits and records | Named traits and units; scalar records identify animal, trait, record and optional time/observation unit. Predictions retain fitting provenance, information date and reporting base. Missing values are NA, not zero. |
| Markers | Unique rsids aligned to physical marker metadata, counted/effect and other allele, chromosome, position and assembly. Never silently reverse alleles or infer strand. |
| Genotypes | Tiny teaching matrices have individual rows and marker columns, raw counted-allele dosage 0/1/2 and NA. Initial scope is diploid/biallelic. Fractional dosage/polyploidy need explicit later contracts. BED counts BIM A1/bit1; dosage does not identify haplotype phase. |
| Reference populations | Explicit sample/population definition, allele frequencies, orientation, centering/scaling and genetic base. Keep the same base across cohorts to measure gain. Separate fitted quantities and simulated truth. |
| Covariances and relationships | Label both axes; align by identity. Record units, symmetry/PSD assumptions, covariance versus correlation, and additive relationship versus kinship normalization. |
| Missingness | NA with reported called denominators, exclusions and imputation/score policy; no silent imputation. |

Ordinary data frames, named vectors and labelled small matrices come first.
Future packed workflows should use installed gbase/gbits/gmat public resources,
validate physical identity and process bounded chunks. Whole-genome dense
genotypes or relationships are not a scalable default; report materialization,
memory limits and retained output sizes. No copied sibling sources/private headers.

Neither package depends on umbrella gsuite. gpop describes statistics/models;
gsel describes decisions and programme design. gsel may later optionally consume
gpop diversity summaries; gpop must not depend on gsel. Neither is imported by
gsim. A future gsel simulation adapter may optionally invoke gsim; real-population
workflows require no simulator. Model fitting and genetic evaluation remain in
their existing owners. Add gbase/native dependencies only for demonstrated
executable needs; these foundations have only a base-R dependency.
