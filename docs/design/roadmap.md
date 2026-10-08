# Roadmap and teaching references

1. **Labelled objective and linear index.** Named economic weights, supplied
   positive-definite P and cross-covariance C; solve P b=C a. Verify hand-solvable
   diagonal/correlated cases, trait order, units, sign/scaling, invalid dimensions
   and singularity. No fitted predictor, simulator or optimizer initially.
2. **Explicit selection policies.** Eligibility, family quotas and deterministic
   ties; exhaust tiny candidate sets. Design multistage costs/information first.
   Reuse/adapt gsim public mechanics deliberately rather than copy code.
3. **Contributions and allocation.** Agree normalization/coancestry first.
   Compare tiny contribution problems with analytic/exhaustive optima and tiny
   mating allocations with enumerated pair counts. Add installed numerical
   dependencies only when needed, not an empty native backend.
4. **Programme evaluation.** Cohort/age/resource tables, optional gsim experiments
   and externally fitted evaluations. Compare analytic response/time/cost with
   labelled known-truth evidence; real populations need no simulation dependency.

Teaching references: two-trait conflicting weights; family caps; gain-coancestry
frontier; allocation versus random mating; generation interval versus annual
gain; genotyping/recording budgets. The installed example is covariance algebra,
not a method implementation. Every milestone needs an independent oracle and
scoped qualification; no breeding-outcome or scalability claims are established.
