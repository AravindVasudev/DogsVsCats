from keras.models import load_model
import cv2

model = load_model('./dogsvscats.h5')

def classify(path):
    img = cv2.imread(path, cv2.IMREAD_COLOR)
    img = cv2.resize(img, (64, 64), interpolation=cv2.INTER_CUBIC)
    img = img.reshape(1, 64, 64, 3)

    return model.predict(img)
