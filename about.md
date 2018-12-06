# App Proposal

We would like to build an app that uses the devices camera to capture the users face (there are r packages that handle most of this) and then determines if the user is Sam Doku (this is a simplification to make the project more manageable). The goal here is really learning to experiment more with additional inputs in shiny as well as image recognition in R.

# Business Case
While are initial implementation would be more of a simplified proof of concept, face recognition is the current trend in identity verification. While an implementation like this wouldn’t be ideal for actual security we believe it could be useful in creating adaptive dashboards that show data pertinent to a given user. One example would be adapting visualization specifically for color blind users, while still being able to use more traditional colors with their associated connotations and meanings for general users.

# Data
In this case the data would be mainly photographs

# Approach
## 1 - Identify Faces
## 2 - Pose and Project Faces
## 3 - Encode Face
## 4 - Match Encoding to Identity
The method we are looking at uses a neural net implementation called FaceNet. FaceNet uses a Siamese Neural Network approach, meaning that it uses to neural networks with identical weights and runs each image through one of the networks and then compares the distance between the resulting output to determine if the images contain the same identity. The neural networks learns a mapping of images to compact Euclidean space and use that to calculate the distance between two images. Additionally, the model uses the loss function described below in training to minimize the distance between an anchor and a positive, images that contain the same identity, and maximize the distance between the anchor and a negative, images that contain different identities.



	
 
