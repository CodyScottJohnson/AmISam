import face_recognition

known_image = face_recognition.load_image_file("Images/Sam.png")

Known_encoding = face_recognition.face_encodings(known_image)[0]
unknown_image = face_recognition.load_image_file('Images/notsam.png')
if(len(face_recognition.face_encodings(unknown_image))>= 1):
    unknown_encoding = face_recognition.face_encodings(unknown_image)[0]
    results = face_recognition.compare_faces([Known_encoding], unknown_encoding)
else:
    results = ["FALSE"]