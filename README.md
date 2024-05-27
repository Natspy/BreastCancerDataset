# Breast Cancer Clinical Profiles Dataset

This repository contains a preprocessed dataset of clinical profiles for 2,509 breast cancer patients. The dataset is based on the [Breast Cancer METABRIC](https://www.kaggle.com/datasets/gunesevitan/breast-cancer-metabric/data), with additional processing to include specific dates related to the research timeline and patient outcomes.

## Modifications

- **Dates Added**: Based on the research timeline (1977-2005), the following columns were added:
  - `Entry_date` - Date of diagnosis of a patient
  - `End_of_time` - End date of the study period
  - `Date_died` - Based on `Overall Survival (Months)`

## Usage

### Loading the Data

You can load the dataset using Pandas in Python as follows:

```python
import pandas as pd

# Load the dataset
df = pd.read_csv('BreastCancerDataset.csv')

# Display the first few rows
print(df.head())
```

## Columns

<div style="column-count: 2;">

- `Patient ID`: Unique identifier.
- `Age at Diagnosis`: Age at diagnosis.
- `Type of Breast Surgery`: Type of breast surgery.
- `Cancer Type`: Type of cancer.
- `Cancer Type Detailed`: Detailed cancer type.
- `Cellularity`: Cellularity of the tumor.
- `Chemotherapy`: Whether the patient had chemotherapy.
- `Pam50 + Claudin-low subtype`: Breast cancer subtype.
- `Cohort`: Cohort the patient belongs to.
- `ER status measured by IHC`: Estrogen receptor status measured by IHC.
- `ER Status`: Estrogen receptor status.
- `Neoplasm Histologic Grade`: Histologic grade of the tumor.
- `HER2 status measured by SNP6`: HER2 status measured by SNP6.
- `HER2 Status`: HER2 receptor status.
- `Tumor Other Histologic Subtype`: Other histologic subtype of the tumor.
- `Hormone Therapy`: Whether the patient received hormone therapy.
- `Inferred Menopausal State`: Menopausal state inferred from data.
- `Integrative Cluster`: Integrative cluster classification.
- `Primary Tumor Laterality`: Laterality of the primary tumor.
- `Lymph nodes examined positive`: Number of positive lymph nodes.
- `Mutation Count`: Count of mutations.
- `Nottingham prognostic index`: Nottingham prognostic index score.
- `Oncotree Code`: Oncotree classification code.
- `Overall Survival (Months)`: Overall survival time in months.
- `Overall Survival Status`: Status of overall survival.
- `PR Status`: Progesterone receptor status.
- `Radio Therapy`: Whether the patient received radiotherapy.
- `Relapse Free Status (Months)`: Relapse-free survival time in months.
- `Relapse Free Status`: Status of relapse-free survival.
- `Sex`: Sex of the patient.
- `3-Gene classifier subtype`: 3-gene classifier subtype.
- `Tumor Size`: Size of the tumor.
- `Tumor Stage`: Stage of the tumor.
- `Patient's Vital Status`: Vital status of the patient.
- `Entry_date`: Date of diagnosis of a patient.
- `End_of_time`: End date of the study period.
- `Date_died`: Date of death.

</div>
