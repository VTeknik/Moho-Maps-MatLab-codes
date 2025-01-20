# Moho-Maps-MatLab-Codes

This repository contains MATLAB codes developed for generating high-resolution Moho depth maps using data-driven and machine learning techniques. The results from these codes were published in the journal *Tectonophysics* (2024): "The improved Moho depth imaging in the Arabia-Eurasia collision zone: A machine learning approach integrating seismic observations and satellite gravity data" by Vahid Teknik.

---

## Features

- **Seismically Constrained Moho Model (S-Moho)**: Compiles nearly 2500 seismic measurements to develop a high-resolution Moho depth model at 0.5° × 0.5° spatial resolution.
- **Gravity-Based Regression Moho Model (SB-Moho)**: Uses Bouguer anomalies to predict Moho depths, addressing spatial gaps in seismic data.
- **Sliding Window Regression (WSB-Moho)**: Applies localized regression to refine the SB-Moho model and improve spatial continuity.
- **Machine Learning-Based Moho Model (ML-Moho)**: Integrates seismic data and 11 predictive variables to produce a robust and smooth Moho depth model.
- **Visualization Tools**: Includes scripts for plotting and saving figures to analyze results.

---

## Repository Structure

### Main Files

- **`ApplyTrainedModel_v20220715.m`**: Applies pre-trained machine learning models to predict Moho depth.
- **`ApplyTrainedModel_v20220720_regresion.m`**: Regression-based implementation for Moho depth prediction.
- **`BgMoho.m`**: Computes the Bouguer anomaly-based Moho depth model.
- **`BgMoho_fa_color.m`**: Generates Bouguer anomaly-based Moho depth maps with color coding.
- **`MohoBG_v20220712.m`**: Main script for generating Moho depth models using regression techniques.
- **`ReadTrainingModel_v20220714.m`**: Loads and processes training datasets for machine learning-based modeling.
- **`Save_figures.m`**: Utility to save generated figures for documentation.
- **`featureSelection.m`**: Selects predictive variables for machine learning models.
- **`mohotopo.m`**: Generates topographic and tectonic overlays for Moho maps.
- **Polynomial and Regression Utilities**:
  - **`polydern.m`, `polyfitn.m`, `polyn2sym.m`, `polyn2sympoly.m`, `polyvaln.m`**: Polynomial fitting and evaluation utilities.
- **`scatter_kde.m`**: Kernel density estimation for scatterplot visualization.

---

## Requirements

- **MATLAB**: Version R2018b or newer is recommended.
- **Data**: Input seismic measurements and Bouguer anomaly data (formatted according to the provided scripts).
- **Dependencies**: Standard MATLAB toolboxes (e.g., Statistics and Machine Learning Toolbox).

---

## Usage

### 1. Clone the Repository
```bash
git clone https://github.com/VTeknik/Moho-Maps-MatLab-codes.git
cd Moho-Maps-MatLab-codes
```

### 2. Load Input Data
Prepare your seismic Moho depth data and Bouguer anomaly data in the required format.

### 3. Select and Run Scripts
- To apply machine learning models:
  ```matlab
  run('ApplyTrainedModel_v20220715.m')
  ```
- To use regression-based methods:
  ```matlab
  run('MohoBG_v20220712.m')
  ```

### 4. Visualize Results
Use visualization scripts like `BgMoho_fa_color.m` and `scatter_kde.m` to analyze and save the results.

---

## Example Workflow

1. **Load seismic data**:
   ```matlab
   ReadTrainingModel_v20220714;
   ```
2. **Run regression-based modeling**:
   ```matlab
   MohoBG_v20220712;
   ```
3. **Generate Bouguer anomaly maps**:
   ```matlab
   BgMoho_fa_color;
   ```
4. **Apply machine learning models**:
   ```matlab
   ApplyTrainedModel_v20220715;
   ```
5. **Save figures**:
   ```matlab
   Save_figures;
   ```

---

## Publication

The methods and results are detailed in the following publication:

> **The improved Moho depth imaging in the Arabia-Eurasia collision zone: A machine learning approach integrating seismic observations and satellite gravity data**
> Vahid Teknik, Tectonophysics, Volume 893, 20 December 2024, 230553, [https://doi.org/10.1016/j.tecto.2024.230553](https://doi.org/10.1016/j.tecto.2024.230553)

### Highlights

- Compiled seismically measured Moho depth values to derive Moho depth models with 0.5° × 0.5° resolution.
- Utilized data-driven and machine learning techniques to enhance Moho map coverage and accuracy.
- Identified a pronounced Moho depression, revealing deep crustal deformation across the Zagros.

---

## Contributing

Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed explanation of your changes.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Contact

For questions or further information, contact [Vahid Teknik](mailto:vahid.teknik@gmail.com).

