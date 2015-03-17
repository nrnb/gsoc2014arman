# About
This is the repository that contains code relevant to the Google Summer of Code 2014 project titled "[Idea 15: Work on the Pathway Database Converters for the Expansion of Pathway Commons](http://cbio.mskcc.org/~arman/gsoc14/Idea15_PathwayCommonsConverters.pdf)".
This project is being conducted under the mentorship of [National Resouce for Network Biology (NRNB)](http://nrnb.org) with the help of [Google](http://google.com)'s GSOC'14 program.
Feel free to contact the author, [B. Arman Aksoy](mailto:armish@gmail.com) if you have any questions about the project and the code.

## Pathway Commons
[Pathway Commons (PC)](http://www.pathwaycommons.org) is a network biology resource and acts as a convenient point of access to biological pathway information collected from public pathway databases, which you can search, visualize and download. The PC framework allows aggregating and normalizing data from multiple biological pathway databases by utilizing BioPAX, a standard language that aims to enable integration, exchange, visualization and analysis of biological pathway data.

PC currently includes data from Reactome, NCI PID, HumanCyc, PhosphoSitePlus and PANTHER—data resources that already export their data in BioPAX format. It further imports data from HPRD by taking advantage of a tool that converts data from PSI-MI to BioPAX format. 

Although there are many other BioPAX-supporting data resources, PC currently lacks biological pathway data about drug activity, transcription factor mediated events and detailed metabolism reactions. Data for such biological processes already exist and publicly available from various resources, but inclusion of these databases into PC requires converters that will convert these data sets to BioPAX.

All PC data is freely available, under the license terms of each contributing database. This allows PC to combine and re-distribute databases that utilize different databases and when necessary (e.g. if the data provider does not originally allow re-distribution of the data) permission from the data provider is granted before importing it into PC.

# Project Goals
Pathway Commons aggregates biological pathway information from several pathway databases; the data are stored primarily in the format known as BioPAX. The PC database currently includes data from resources that already provide data in BioPAX format, such as Reactome and HumanCyc. The aim of this project is to extend Pathway Commons framework by implementing importers/converters for other data resources that do not provide their data in BioPAX but are of high interest to biologists.

## Goal 1: Recon 2 Converter
### Proposal
Although there already exists an [SBML-to-BioPAX converter](https://sourceforge.net/apps/mediawiki/sbfc/index.php?title=Main_Page#SBML_to_BioPax), the produced BioPAX does not validate via the official BioPAX Validator and contain semantic errors, hindering its import into PC. For this part of the project, I will fix the SBML-to-BioPAX converter and make sure that it produces a valid BioPAX file with proper external identification information. 

- **Home page**: [http://humanmetabolism.org](http://humanmetabolism.org) (also see Thiele *et al.*, 2013)
- **Type**: Human metabolism
- **Format**: SBML (Systems Biology Markup Language)
- **License**: N/A (Public)

### Implementation details
The existing converter was originally written for converting SBML 2 models into BioPAX and obviously was extended later to support BioPAX L3 as well.
This being said, the converter was not making good use of all Paxtools utilities that can make the code much simpler and cleaner.
I first tried to modify the existing code, but stuck with library conflicts and was not able to resolve the problems.
See the initial changesets starting from tag `base1` till `milestone1.1`.

To keep things much simpler, I created a new project from the scratch under `Goal1-SBML2BioPAX/sbml2biopax`.
This project depends on two libraries: Paxtools and JSBML.
I implemented the converter so that this project can be used a library by other projects as well.
The main class of this project, `SBML2BioPAXMain`, serves as an example to show how to use this API:

	:::java
	// ...
	SBMLDocument sbmlDocument = SBMLReader.read(new File(sbmlFile));
	SBML2BioPAXConverter sbml2BioPAXConverter = new SBML2BioPAXConverter();
    Model bpModel = sbml2BioPAXConverter.convert(sbmlDocument);
    // where bpModel is the BioPAX model
    // ...

During implementation, I tried to seperate utility methods and main flow as much as possible,
so that we have all main conversion logic in the `SBML2BioPAXConverter` class and
all utility methods in the `SBML2BioPAXUtilities`.

The logic of the conversion is as follows:

1. Load SBML document
2. Get the parent model in the document
3. Convert SBML::model to BioPAX::Pathway
4. Iterate over all reactions within SBML::model
	1. Convert SBML::reaction to BioPAX::Conversion
	2. Convert all SBML::modifiers to this reaction into BioPAX::Control reactions
	3. Convert all SBML::reactants to BioPAX::leftParticipants
	4. Convert all SBML::products to BioPAX::rightParticipants
	5. If SBML::reaction::isReversible, make BioPAX::Conversion reversible as well
	6. Add all reactions to the parent pathway
5. Fix outstanding issues with the model and complete it by adding missing components

One key thing with this conversion is that, often, external knowledge is required to decide which particular BioPAX class to create.
For example, an SBML::species can be a BioPAX::Complex, Protein, SmallMolecule and *etc*.
Or you can have SBML::reactions as BioPAX::BiochemicalReaction or BioPAX::Transport.
To make these distinctions, this implementation uses SBO Terms used in Recon 2 model.
The good news is that SBO terms serve as a nice reference;
and the bad news is that not all SBML models have these terms/annotations associated with SBML entities.

Due to these issues, the current implementation is coupled to the Recon 2 model.
Although it is possible to convert any other SBML model into BioPAX, the semantics might suffer depending on the annotation details in that particular model.

### Usage
After checking out the repository, change your working directory to the [Goal1-SBML2BioPAX/sbml2biopax](https://bitbucket.org/armish/gsoc14/src/default/Goal1-SBML2BioPAX/sbml2biopax/?at=default):

	$ cd Goal1-SBML2BioPAX/sbml2biopax

To compile the code and create an executable JAR file, run ant:

	$ ant

You can then run the converter as follows:

	$ java -jar out/jar/sbml2biopax/sbml2biopax.jar 
	> Usage: SBML2BioPAX input.sbml output.owl

To test the application, you can download the Recon 2 model either from the corresponding [BioModel page](http://www.ebi.ac.uk/biomodels-main/MODEL1109130000) or from this project's download page: [goal1_input_recon2.sbml.gz](https://bitbucket.org/armish/gsoc14/downloads/goal1_input_recon2.sbml.gz).
The following commands, for example, convert this file into BioPAX:

	$ wget https://bitbucket.org/armish/gsoc14/downloads/goal1_input_recon2.sbml.gz	
	$ gunzip goal1_input_recon2.sbml.gz
	$ java -jar out/jar/sbml2biopax/sbml2biopax.jar goal1_input_recon2.sbml goal1_output_recon2.owl

For sample output, you can check [goal1_output20140529.owl.gz](https://bitbucket.org/armish/gsoc14/downloads/goal1_output20140529.owl.gz).

### Validation results
The validation report for the converted model is pretty good and include only a single type of `error` due to the lack of annotations to some entities in the SBML model.
The HTML report can be accessed from the `Downloads` section: [goal1_sbml2biopax_validationResults_20140529.zip](https://bitbucket.org/armish/gsoc14/downloads/goal1_sbml2biopax_validationResults_20140529.zip).
The outstanding error with the report is related to `EntityReference` instances that don't have any `UnificationXref`s associated with them.
This is not an artifact of the conversion, but rather a result of the lack of annotations in the Recon 2 model,
where some of the `SmallMolecule` species do not have any annotations to them, hence don't have any `UnificationXref`s.


## Goal 2: Comparative Toxicogenomics Database (CTD) Converter
### Proposal
Unlike many other drug-target databases, this data resource has a controlled vocabulary that can be mapped to BioPAX, for example:

“nutlin 3 results in increased expression of BAX”

Therefore implementation of a converter first requires a manual mapping from CTD terms to BioPAX ontology. Once the mapping is done, then the actual conversion requires parsing and integrating multiple CSV files that are distributed by the provider.

- **Home page**: [http://ctdbase.org/](http://ctdbase.org/)
- **Type**: Drug activity
- **Format**: XML/CSV
- **License**: Free for academic use

### Implementation details
The converter is structured as a maven project, where the only major dependencies are *Paxtools* and *JAXB* libraries.
The project can be compiled into an executable JAR file that can be used as a command line utility (described in the next section).

For the conversion, the utility uses three different input files:

1. [Chemical-Gene Interactions](http://ctdbase.org/downloads/#cg) (XML)
2. [Gene Vocabulary](http://ctdbase.org/downloads/#allgenes) (CSV)
3. [Chemical Vocabulary](http://ctdbase.org/downloads/#allchems) (CSV)

all of which can be downloaded from the [CTD Downloads](http://ctdbase.org/downloads/) page.
User can provide any of these files as input and get a BioPAX file as the result of the conversion.
If user provides more than one input, then the converted models are merged and a single BioPAX file is provided as output.

The gene/chemical vocabulary converters produce BioPAX file with only `EntityReference`s in them.
Each entity reference in this converted models includes all the external referneces provided within the vocabulary file.
From the chemical vocabulary, `SmallMoleculeReference`s are produced;
and from the gene vocabulary, various types of references are produced for corresponding CTD gene forms: `ProteinReference`, `DnaReference`, `RnaReference`, `DnaRegionReference` and `RnaRegionReference`.

The interactions file contains all detailed interactions between chemicals and genes, but no background information on the chemical/gene entities.
Therefore it is necessary to convert all these files and merge these models into one in order to get a properly annotated BioPAX model.
The converter exactly does that by making sure that the entity references from the vocabulary files match with the ones produced from the interactions file.
This allows filling in the gaps and annotations of the entities in the final converted model.

The CTD data sets have nested interactions that are captured by their structured XML file and their XML schema: 
[CTD_chem_gene_ixns_structured.xml.gz](http://ctdbase.org/reports/CTD_chem_gene_ixns_structured.xml.gz) and [CTD_chem_gene_ixns_structured.xsd](http://ctdbase.org/reports/CTD_chem_gene_ixns_structured.xsd).
The converter takes advantage of `JAXB` library to handle this structured data set.
The automatically generated Java classes that correspond to this schema can be found under [src/main/java/org/ctdbase/model](https://bitbucket.org/armish/gsoc14/src/default/Goal2-CTD2BioPAX/ctd2biopax/src/main/java/org/ctdbase/model/?at=default).
The simple flow that show how the conversion happens is available as the main executable class: [CTD2BioPAXConverterMain.java](https://bitbucket.org/armish/gsoc14/src/default/Goal2-CTD2BioPAX/ctd2biopax/src/main/java/com/google/gsoc14/ctd2biopax/CTD2BioPAXConverterMain.java?at=default).

### Usage
Check out the latest code and change your directory to [Goal2-CTD2BioPAX/ctd2biopax](https://bitbucket.org/armish/gsoc14/src/default/Goal2-CTD2BioPAX/ctd2biopax/?at=default):

	$ cd Goal2-CTD2BioPAX/ctd2biopax

and do a clean mvn install:

	$ mvn clean install assembly:single

This will create a single executable JAR file under the `target/` directory, with the following file name: `ctd2biopax-{version}-single.jar`.
You can also download this file under the downloads, e.g. [ctd2biopax-1.0-SNAPSHOT-single.jar](https://bitbucket.org/armish/gsoc14/downloads/ctd2biopax-1.0-SNAPSHOT-single.jar).
Once you have the single JAR file, you can try to run without any command line options to see the help text:

	$ java -jar ctd2biopax-1.0-SNAPSHOT-single.jar
	usage: CTD2BioPAXConverterMain
	 -c,--chemical <arg>      CTD chemical vocabulary (CSV) [optional]
	 -g,--gene <arg>          CTD gene vocabulary (CSV) [optional]
	 -o,--output <arg>        Output (BioPAX file) [required]
	 -r,--remove-tangling     Remove tangling entities for clean-up [optional]
	 -x,--interaction <arg>   structured chemical-gene interaction file (XML)
	                          [optional]

All input files (chemicals/genes/interactions) can be downloaded from the [CTD Downloads page](http://ctdbase.org/downloads/).
If you want to test the converter though, you can download smallish examples for all these files from the downloads page: [goal2_ctd_smallSampleInputFiles-20140702.zip](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_smallSampleInputFiles-20140702.zip).
To convert these sample files into a single BioPAX file, run the following command:

	$ java -jar ctd2biopax-1.0-SNAPSHOT-single.jar -x ctd_small.xml -c CTD_chemicals_small.csv -g CTD_genes_small.csv -r -o ctd.owl

which will create the `ctd.owl` file for you.
You can find a sample converted BioPAX file from the following link: [goal2_ctd_smallSampleConverted-20140703.owl.gz](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_smallSampleConverted-20140703.owl.gz).
Once you have the file, you can then visualize this small sample file with [ChiBE](https://code.google.com/p/chibe/), which will list all available pathways in the model first.

![CTD Pathway List](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_small_screenshot_pathwaysList.png)

and you can, for example, load the `Homo sapiens` pathway and this is what you will get:

![CTD Homo Sapiens Sample](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_small_pathwayView.jpg)

The tool will also print log information to the console, for example: [goal2_ctd_smallSampleConversion.log.gz](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_smallSampleConversion.log).

If you'd like, you can download the fullly converted CTD data and its log from the following links: [goal2_ctd_fullConverted.owl.bz2](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_fullConverted.owl.bz2) and [goal2_ctd-fullConversion.log.gz](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd-fullConversion.log.gz).

### Validation results
Since the fully converted CTD model is huge (> 4 Gb), I only validated the small sample data set, which is representative of the full one: [goal2_ctd_validationResults_20140703.zip](https://bitbucket.org/armish/gsoc14/downloads/goal2_ctd_validationResults_20140703.zip).
In the validation reports, we have a single type of `ERROR` that reports the lack of external references for some of the `EntityReference`s.
These are mostly due to lack of information in the sample chemical/gene vocabularies and are not valid for the full CTD data set -- which has all the necessary background information on all entities.

Original CTD model assumes all entities are forms of `Gene`s, hence provides unification xrefs to the *NCBI Gene* database for all entities.
This creates a problem in the converted BioPAX file, where we add gene xrefs to the protein entities for some of the CTD reactions.
This also causes some of the unification xrefs to be shared across entities (e.g. `DNA` and `Protein`).
The options to get rid of these problems will be discussed with the mentors/curators.

These issues that are related to the data source are [all entered](https://bitbucket.org/armish/gsoc14/issues?title=~Goal+2) to our Issue Tracker.