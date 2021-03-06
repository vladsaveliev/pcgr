FAQ
---

Frequently asked questions regarding PCGR usage and functionality:

**1. Why do I get a long list of lines with “ERROR: Line ..” during
“STEP 0: validate input data”?**

*Answer: Your query VCF does not pass the VCF validation check by*
`EBI’s vcf-validator <https://github.com/EBIvariation/vcf-validator>`__.
*Solution: 1) Fix the VCF so that it adheres to the VCF standard, or 2)
run PCGR with option ``--vcf_no_validate`` if you think the formatting
problems is not critical to the contents of the VCF.*

**2. I am not sure how to specify depth/allelic fraction in my query
VCF. Why cannot PCGR pull out this information automatically from my VCF
file?**

*Answer: This is something that you as a user need to handle yourself.
To our knowledge, there is currently no standard way that variant
callers format these types of data (allelic fraction/depth,
tumor/normal) in the VCF, and this makes it very challenging for PCGR to
automatically grab this information from the variety of VCFs produced by
different variant callers. Please take a careful look at the example VCF
files (``examples`` folder) that comes with PCGR for how PCGR expects
this information to be formatted, and make sure your VCF is formatted
accordingly.*

**3. Is it possible to utilize PCGR for analysis of multiple samples?**

*Answer: As the name of the tool implies, PCGR was developed for the
detailed analysis of individual tumor samples. However, if you take
advantage of the different outputs from PCGR, it can also be utilized
for analysis of multiple samples. First, make sure your input files are
organized per sample (i.e. one VCF file per sample, one CNA file per
sample), so that they can be fed directly to PCGR. Now, once all samples
have been processed with PCGR, note that all the tab-separated output
files (i.e. tiers, mutational signatures, cna segments) contain the
sample identifier, which enable them to be aggregated and suitable for a
downstream multi-sample analysis.*

*Also note that the compressed JSON output pr. sample run
contains*\ **ALL**\ *information presented in the report. Explore the
JSON contents e.g. with the* `jsonlite
package <https://github.com/jeroen/jsonlite>`__ *in R:*

``report_data <- jsonlite::fromJSON('<sample_id>.pcgr_acmg.grch37.json.gz')``

*E.g. tiered SNV/InDel output*:

``head(report_data$content$snv_indel$variant_set$tsv)``

*Or TMB estimate*:

``report_data$content$tmb$variant_statistic$tmb_estimate``

**4. I do not see the expected transcript-specific consequence for a
particular variant. In what way is the primary variant consequence
established?**

*Answer: PCGR relies upon*
`VEP <https://www.ensembl.org/info/docs/tools/vep/index.html>`__ *for
consequence prioritization, in which a specific transcript-specific
consequence is chosen as the primary variant consequence. In the PCGR
configuration file, you may customise how this is chosen by changing the
order of criteria applied when choosing a primary consequence block -
parameter*
`vep_pick_order <https://www.ensembl.org/info/docs/tools/vep/script/vep_other.html#pick_options>`__

**5. Is it possible to use RefSeq as the underlying gene transcript
model in PCGR?**

*Answer: PCGR uses GENCODE as the primary gene transcript model, but we
provide cross-references to corresponding RefSeq transcripts when this
is available.*

**6. I have a VCF with structural variants detected in my tumor sample,
can PCGR process those as well?**

*Answer: This is currently not supported as input for PCGR, but is
something we want to incorporate in the future.*

**7. I am surprised to see a particular gene being located in TIER 3 for
my sample, since I know that this gene is of potential clinical
significance in the tumor type I am investigating?**

*Answer: PCGR classifies variants into tiers of significance through an
implementation of* `published guidelines by
ACMG/AMP <https://pcgr.readthedocs.io/en/latest/tier_systems.html>`__.
*No manual efforts for individual tumor types are conducted beyond this
rule-based scheme. The users need to keep this in mind when interpreting
the tier contents of the report.*

**8. Is it possible to see all the invididual cancer subtypes that
belong to each of the 30 different tumor sites?**

*Answer: Yes, see*
`oncotree_ontology_xref.tsv <https://raw.githubusercontent.com/sigven/pcgr/master/oncotree_ontology_xref.tsv>`__

**9. Is there any plans to incorporate data from**
`OncoKB <https://www.oncokb.org>`__ **in PCGR?**

*Answer: No. PCGR relies upon publicly available open-source resources,
and further that the PCGR data bundle can be distributed freely to the
user community. It is our understanding that* `OncoKB’s terms of
use <https://www.oncokb.org/terms>`__ *do not fit well with this
strategy.*

**10. Is it possible for the users to update the data bundle to get the
most recent versions of all underlying data sources?**

*Answer: As of now, the data bundle is updated only with each release of
PCGR. This is not yet supported, but we want to allow for such updates
in the future.*
