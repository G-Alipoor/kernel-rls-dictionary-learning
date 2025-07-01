# Kernel Recursive Least Squares Dictionary Learning Algorithm

This repository contains the complete MATLAB code and datasets necessary to reproduce the results of the following research article:

📄 **Title**: Kernel Recursive Least Squares Dictionary Learning Algorithm  
👥 **Authors**: Ghasem Alipoor, Karl Skretting  
📚 **Published in**: *Digital Signal Processing: A Review Journal*, Volume 141, 2023  
🔗 [DOI: 10.1016/j.dsp.2023.104159](https://doi.org/10.1016/j.dsp.2023.104159)

> 🛑 **Note**: This repository contains the final version of the code and is not under active development.

---

## 🧠 Abstract

We propose an efficient online dictionary learning algorithm for kernel-based sparse representations. The method uses a recursive least squares (RLS) strategy to incrementally train a virtual dictionary in kernel space. It supports both single-sample and mini-batch updates. The proposed method achieves classification accuracy comparable to batch-mode training, while maintaining low computational complexity. Experiments on four datasets demonstrate its superiority over existing online kernel dictionary learning methods.

---

## 📁 Repository Structure

- `Data/`  
  Contains all datasets used in the experiments.  
  📦 **Important**: Please extract the `DistNet.rar` file before running the code.

- `Functions/`  
  Core MATLAB functions implementing the proposed and baseline dictionary learning algorithms.

- `Tests/`  
  Scripts used to reproduce the experimental results reported in the paper.  
  ✅ To run all tests and reproduce results, execute:
  ```matlab
  tests
  ```

- `Results/`  
  Contains saved `.mat` files and plotted figures. These results are automatically regenerated when the test scripts are executed. Precomputed versions are included for convenience.

---

## 🛠 Requirements

- MATLAB R2018 or later  
- Statistics and Machine Learning Toolbox (recommended)  
- No external libraries required

---

## 🔁 Reproducibility

All results reported in the paper can be reproduced using the provided scripts and datasets. If you encounter any issues, please ensure the datasets are fully extracted and the correct folder paths are set.

---

## 📚 Citation

If you use this code or refer to this work, please cite the following:

```bibtex
@article{Alipoor2023KernelRLS,
  title={Kernel Recursive Least Squares Dictionary Learning Algorithm},
  author={Ghasem Alipoor and Karl Skretting},
  journal={Digital Signal Processing},
  volume={141},
  pages={104159},
  year={2023},
  doi={10.1016/j.dsp.2023.104159}
}
```

---

## 🔗 Additional Links

- 📄 [Published Paper on Elsevier](https://doi.org/10.1016/j.dsp.2023.104159)
- 📄 [arXiv Preprint](https://arxiv.org/abs/2506.xxxxx)

---

## 📧 Contact

For questions or clarifications, please contact:  
📨 Ghasem Alipoor — alipoor@hut.ac.ir, g.alipoor@gmail.com
