from keras.models import load_model
import cv2

SIZE = (64, 64)
model = load_model('dogsvscats.h5')

def read_image(path):
    img = cv2.imread(path, cv2.IMREAD_COLOR) # read as grayscale
    return cv2.resize(img, SIZE, interpolation=cv2.INTER_CUBIC) # resize to 64x64

img = read_image('./test.jpg')
img = img.reshape(1, 64, 64, 3)

op = model.predict(img)

print(op)
