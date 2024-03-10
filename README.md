# UI
A website user interface that predicts specific crop yields in certain locations based on an weather app api and soil type. The user interface will consist of a typing menu where you will input location, Nitrogen, Phosphorous, Potassium and Temperature (decided through a weather api), humidity, soil ph value, and rainfall in mm. When location has been selected an image of a zoomable map of that area will appear with whatever choices selected and a prediction of that information. The predict button will output if that crop is likely to have good yield in that environment.

# Dataset
Crop Recommendation Dataset - 
https://dataverse.harvard.edu/file.xhtml?fileId=6881146&version=1.0&toolType=PREVIEW

# APIS
The Website will use a map api which can be used to search through local farms. A temperature, humidity, and rainfall api will be used to find data for the ml model.

# ML Model
A ml model will use old data (weather data patterns and crop reaction to those types of weather in different soils) and predict the outcome of certain crops in different areas.

