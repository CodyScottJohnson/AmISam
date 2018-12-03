import face_recognition
from PIL import Image, ImageDraw
import face_recognition

# Load the jpg file into a numpy array
image = face_recognition.load_image_file("Images/notsam.png")

# Find all facial features in all the faces in the image
face_landmarks_list = face_recognition.face_landmarks(image)

# Create a PIL imagedraw object so we can draw on the picture
pil_image = Image.fromarray(image)
d = ImageDraw.Draw(pil_image)

for face_landmarks in face_landmarks_list:

    # Print the location of each facial feature in this image
    points = '<div class="tbl_con"><table class="face_features"><tr><th>Feature</th><th>Points</th></tr>'
    for facial_feature in face_landmarks.keys():
        points += '<tr><td class="feature">{}</td><td class="point">{}</td></tr>'.format(facial_feature, face_landmarks[facial_feature]) 


    # Let's trace out each facial feature in the image with a line!
    for facial_feature in face_landmarks.keys():
        d.line(face_landmarks[facial_feature], width=5)

# Show the picture
points += '</table></div>'
pil_image.save("www/notsam_marked.png")