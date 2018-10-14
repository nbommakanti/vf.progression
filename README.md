# VF Progression

## Description
This is a (very) rough start to a package aimed at providing a free, open-source means to perform trend-based visual field analysis to monitor patients who have glaucoma or who are suspected to have the possibility to develop glaucoma.

I envision this package running on a laptop connected to a Humphrey Visual Fields machine. When a visual fields test is performed, the data can be exported to the computer then run through this program to generate a patient-specific report demonstrating his or her progression over time, on both a global (mean deviation) and local (total deviation) basis.

This may provide the clinician a convenient, useful tool to monitor the long-term status of his or her patients. This program is intended to run automatically, so (once this feature is implemented) it will provide this benefit toward patient care without adding an additional time burden for the medical team.

Similar functionality is provided by commercial packages (e.g. STATPAC and PROGRESSOR). The advantages of this program are:

- It is free (and can therefore be used in resource-limited settings)
- It is open-source (and can therefore be extended and improved by any number of interested contributors)


## Running the program
You may run the program as follows:

```
# Load the package
library(vf.progression)

# Get a vector of paths to the xml files
xml_paths <- list.files("my/xml/folder")

# Run the program
vf_progression(xml_paths)
```
