# Selection and breeding scope and proposed interfaces

All names below are proposals, not exported or implemented functions.

| Proposal | Scientific role | Assumptions to declare |
| --- | --- | --- |
| gsel_objective | Breeding objectives and trait economic weights | Trait units, reporting base; economic value, observed score and breeding value differ. |
| gsel_index | Index from supplied covariance inputs | P=Var(x), C=Cov(x,u), H=a-transpose u, I=b-transpose x; solve P b=C a for positive-definite P. Fitting remains external. |
| gsel_select | Truncation, family, multistage and genomic policies | Eligibility, quotas, ties, missing predictions, stage-specific available information and costs. Genomic selection is not a new genomic predictor. |
| gsel_contributions | Optimum contributions | Gene contributions versus parent-use counts, normalization, role/bound constraints, labelled PSD relationship, feasibility/optimality diagnostics. |
| gsel_mating | Allocation and crossbreeding | Pair/offspring counts, roles, capacity, relatedness and breed composition; supplied heterosis/breed-effect models. Allocation does not generate offspring. |
| gsel_programme | Cohorts, ages, stages and resources | Ordinary recording/genotyping/time/cost tables; overlapping generations and units explicit. |
| gsel_evaluate / gsel_compare | Evaluation and later optimization | Gain on fixed base, diversity, inbreeding, time and cost separately; analytic predictions, observed results and simulated evidence remain distinct. |

For a linear index use the justified cross-covariance C, not Var(u) automatically
for arbitrary predictions. Response/intensity/distribution assumptions are
separate from solving the covariance equation. For additive relationship A and
gene contributions c summing to one, group coancestry is c-transpose A c / 2.
State normalization/factor-of-two conventions; this is not offspring inbreeding
without a mating plan. Real populations supply external predictions/relationships
without gsim. Never select using hidden simulation truth implicitly.
No selection, index, mating or optimization API is implemented yet.
