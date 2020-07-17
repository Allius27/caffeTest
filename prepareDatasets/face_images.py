import numpy as np
import numpy as np
import pandas as pd
import os
import cv2
import random
import matplotlib.pyplot as plt

image = np.moveaxis(np.load('face_images.npz')['face_images'],-1,0)
points = pd.read_csv('facial_keypoints.csv')

for pic in range(0,image.shape[0]):

	# pic = 1808

	if (
			points.left_eye_center_x.isna() & points.left_eye_center_y.isna() |
			points.right_eye_center_x.isna() & points.right_eye_center_y.isna() |
			points.nose_tip_x.isna() & points.nose_tip_y.isna() |
			points.mouth_left_corner_x.isna() & points.mouth_left_corner_y.isna() |
			points.mouth_right_corner_x.isna() & points.mouth_right_corner_y.isna())[pic]:
		print("skip " + str(pic))
		continue

	print("Process " + str(pic) + " of " + str(image.shape[0]) + " images" )


	img = image[pic]
	img = np.uint8(img)

	leftEye = (int(points.left_eye_center_x[pic]), int(points.left_eye_center_y[pic]))
	rightEye = (int(points.right_eye_center_x[pic]), int(points.right_eye_center_y[pic]))

	nose = (int(points.nose_tip_x[pic]), int(points.nose_tip_y[pic]))
	mouth1 = (int(points.mouth_left_corner_x[pic]), int(points.mouth_left_corner_y[pic]))
	mouth2 = (int(points.mouth_right_corner_x[pic]), int(points.mouth_right_corner_y[pic]))

	eyeDist = leftEye[0] - rightEye[0]

	mouthYmid = int(( points.mouth_left_corner_y[pic] + points.mouth_right_corner_y[pic] )/2)
	dY = int(( mouthYmid - points.nose_tip_y[pic] )/2)

	mouthAreaX = int( mouth1[0] + eyeDist/2 )
	mouthAreaY = int( points.nose_tip_y[pic] + dY/2 )
	mouthAreaW = int( mouth2[0] - eyeDist/2 )
	mouthAreaH = int( mouthYmid + dY )

	if mouthAreaX < 0: mouthAreaX = 0
	if mouthAreaY < 0: mouthAreaY = 0
	if mouthAreaH < 0: mouthAreaH = 0
	if mouthAreaW < 0: mouthAreaW = 0

# visualize rectangle and points
# 	cv2.rectangle(img, (mouthAreaX, mouthAreaY), (mouthAreaW, mouthAreaH), (255,255,0), 2 )
# 	for point in nose, mouth1, mouth2, leftEye, rightEye:
# 		cv2.circle(img, point, 3, (255,255,0))
# 	cv2.imshow("123", img)
# 	cv2.waitKey(0)

# save an image
	roi = img[mouthAreaY:mouthAreaH,mouthAreaW:mouthAreaX]

# skip small pictures
	if roi.shape[0] < 15:
		continue

	if not os.path.isdir("mouth"):
		os.mkdir("mouth")

	cv2.imwrite( "mouth/" + str(pic) + ".jpg", roi )
