# Reusable components and responsibility overlap

Inspected local gsim 0.17.0 at ea10c33 on 2026-10-08: current source/public help,
breeding example, focused tests, scientific contracts and dated qualification.
No code was moved/copied and no existing qualification was rerun or transferred.

| Existing interface/owner | Reuse opportunity | Ownership and limits |
| --- | --- | --- |
| gsim_pedigree_from_table | Supplied parentage validation and mappings | animal/sire/dam; NA parents; cycles rejected. Not a relationship estimator. |
| gsim_select | Random or externally scored selection, quotas, strata and eligibility | Already implements selection mechanics; gsel owns objective/policy and multistage/resource design. Score ties use UTF-8 ID. Conditional 0/1 inclusion does not establish population sampling support. |
| gsim_mate | Random parentage from disjoint selected sire/dam pools | Uniform independent draws with replacement, not optimum allocation. gsel allocation should supply explicit parentage to existing simulation interfaces. |
| gsim_simulate_cohort | Inheritance and incremental packed offspring | Biological generation stays in gsim. All used parents currently need one phased dataset; no automatic cross-cohort parent archive. |
| gsim_trait_state / gsim_genetic_values | Fixed architecture and reporting base | Truth separate from external predictions; do not re-center selected generations when measuring gain. |
| gsim_records / gsim_sample | Phenotypes and recording/genotyping experiments | gsel specifies policies; gsim generates records/draws. Retained parents alone do not ensure representative sampling. |
| gsim_pool / gsim_pool_covariance | Weighted pools and noise blocks | Bounded traversal and observable records; not predictor fitting or optimization. |
| gbase / gbits / gmat | Genomic resource contracts, physical identities and packed/LD operations | Consume installed public interfaces when needed; do not invent incompatible genome objects. |
| gsolve | Future needed numerical primitives | No empty native backend or private headers. |
| greml / gbayes and estimation owners | Fitted evaluations and uncertainty | gsel consumes external estimates; it does not fit mixed models or genomic predictors. |

The gsim example composes biological stages and supplied scores; its focused
tests qualify mechanics, not the scientific performance of a breeding strategy.
gpop can analyze gsim outputs without owning simulation. Overlapping gsel
selection mechanics need a deliberate public adapter/shared-owner decision,
not a duplicate implementation. No dependency cycle is proposed.

Teaching owners: https://github.com/psoerensen/population-genetics and
https://github.com/psoerensen/quantitative-genetics. They retain course notes,
slides, exercises and apps. Reusable package contracts and tiny arithmetic
examples belong here. Teaching repositories are not build/runtime dependencies.
