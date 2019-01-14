## What Is This

The app that uses the devices camera to capture the users face and then determines if the user is Sam Doku (this is a simplification to make the project more manageable). The goal here is really learning to experiment more with additional inputs in shiny as well as image recognition in R.

## Source Code

[https://github.com/CodyScottJohnson/AmISam](https://github.com/CodyScottJohnson/AmISam)

## Business Case
Modern technology has made image recognition a viable option for a variety of applications. Countries like China have gone so far as to implement a face recognition based social credit score system accross the whole country.

While are initial implementation would be more of a simplified proof of concept, face recognition is the current trend in identity verification. While an implementation like this wouldn’t be ideal for actual security we believe it could be useful in creating adaptive dashboards that show data pertinent to a given user. One example would be adapting visualization specifically for color blind users, while still being able to use more traditional colors with their associated connotations and meanings for general users.

The advantage of the proposed approach is that the ease of adding new faces makes it feasable to train off of employee photos.


## Data
The face net model was initially trained using the VGGFace2 Dataset dataset
[VGGFace2 Dataset](http://www.robots.ox.ac.uk/~vgg/data/vgg_face/)
The dataset contains 9131 identities, this dataset is used to caluclate the weights the model will use when identifying new faces.

After the initial models is trained we then supply images of the identities or faces we wish to identify. Only one image is necassary to train each additional identity. The encodings generated from these images are stored and used to identify new faces.

## Approach
#### 1 - Identify Faces
Before we can compare faces we need to identify a face. To do this we use an approach called Histogram of Oriented Gradients (HOG). First we convert our image to greyscale and then we look at each individual pixel and draw arrows to indicate the direction in which the brightness is changing in surrounding pixels

<p align="center">
    <img src="HOG.png" style="max-width:100%;width:500px"/>
</p>

#### 2 - Pose and Project Faces
Next we need to address the different dirrection a face could be turned. To do this we use the face landmark estimation algorithm developed by 

[One Millisecond Face Alignment with an Ensemble of Regression Trees](http://www.csc.kth.se/~vahidk/papers/KazemiCVPR14.pdf)

We identify 68 specific points (called landmarks) that exist on every face then we rotate, scale and shear the image so that the eyes and mouth are centered.

#### 3 - Encode Face
Finally we can encode our face

We are using an implementation of a neural net commonly refered to as FaceNet. 

[FaceNet: A Unified Embedding for Face Recognition and Clustering](https://arxiv.org/pdf/1503.03832.pdf)

The neural networks learns a mapping of images to compact Euclidean space and use that to calculate the distance between two images. Additionally, the model uses the loss function described below in training to minimize the distance between an anchor and a positive, images that contain the same identity, and maximize the distance between the anchor and a negative, images that contain different identities.

the approach strives for an embedding f(x), from an image x into a feature space R, such that the squared distance
between all faces, independent of imaging conditions, of
the same identity is small, whereas the squared distance between
a pair of face images from different identities is large.

<p align="center">
    <img src="TripletGoal.png" style="width:100%;max-width:500px"/>
</p>

##### Triplet Loss

<p align="center">
    <img src="TripletLoss.png" style="max-width:100%"/>
</p>

#### 4 - Match Encoding to Identity
Finally we need to match our encoded face to a specific identity.

We are using a Siamese Neural Network approach, meaning that we use two neural networks with identical weights, (In this case the face net model we trained above) and run each image through one of the networks and then compares the distance between the resulting output to determine if the images contain the same identity.

At this point we are using an svm model to predict if the two images are the same, but a soft max approach could also be used. The svm model is trained on the 128 points of the image encoding we calcualted earlier.



	
 
