# Block Match Algorithm

The Block Match Algorithm is a MATLAB function designed to detect forged regions in an input image by analyzing the similarity between adjacent blocks. This README provides an overview of the algorithm's purpose, input parameters, and usage.

## Purpose

The purpose of the Block Match Algorithm is to identify forged regions in an image based on differences in content between adjacent blocks. It employs a binary mask to mark suspected forged regions and can visualize the detection process if the 'visualize' option is enabled.

## Usage

To use the Block Match Algorithm, follow these steps:

1. Ensure you have MATLAB installed on your system.

2. Include the provided function `blockMatch(I, t)` in your MATLAB workspace.

3. Call the function using the following syntax:

   ```matlab
   I = imread('input_image.jpg');  % Load your input image
   t = 0.005;  % Set the threshold for similarity
   A = blockMatch(I, t);  % Run the block match algorithm
   ```

4. The output `A` will be a binary mask indicating the suspected forged regions in the input image.

## Function Parameters

The `blockMatch` function takes two parameters:

- `I`: Input image (grayscale or color), to be analyzed for forged regions.
- `t`: Threshold value for similarity comparison between blocks. A lower value detects smaller differences, potentially increasing false positives.

## Algorithm Workflow

1. The input image is converted to double precision.
2. Options for block comparison are set, including block size, step size, visualization, and similarity threshold.
3. If visualization is enabled, the original input image is displayed.
4. Binary masks are initialized to mark forged regions.
5. A scanning grid is generated, defining the positions of blocks to be compared.
6. The algorithm iterates over each block position and extracts the pixel values within that block.
7. Extracted pixel values and block positions are stored in tables and arrays for comparison.
8. The tables are sorted lexicographically, and positions are sorted based on the sorted indices.
9. For each adjacent block pair, the mean absolute difference between their pixel values is calculated.
10. If the difference is below the threshold, the binary mask is applied to both blocks, marking them as suspected forged regions.
11. If visualization is enabled, the binary mask is displayed alongside the original image.

## Note

- The algorithm assumes that similar blocks within the same image region are indicative of forgery, which might not be the case for all types of image manipulations.
- The algorithm's effectiveness might vary depending on the characteristics of the input images and the chosen threshold value.

Feel free to experiment with different threshold values and image inputs to achieve optimal results for your specific use case.
