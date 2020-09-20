import torch
import numpy as np
import matplotlib.pyplot as plt

# Check versions
print("PyTorch version: {}".format(torch.__version__))
print("Numpy version: {}".format(np.__version__))
# Load Iris Dataset
FILE_PATH = "/home/saswati/ml/PyTorch-for-Iris-Dataset/"
MAIN_FILE_NAME = "iris_dataset.txt"
TRAIN_FILE_NAME = "iris_train_dataset.txt"
TEST_FILE_NAME = "iris_test_dataset.txt"

data = np.loadtxt(FILE_PATH+MAIN_FILE_NAME, delimiter=",")
mean_data = np.mean(data[:,:4], axis=0)
std_data = np.std(data[:,:4], axis=0)

train_data = np.loadtxt(FILE_PATH+TRAIN_FILE_NAME, delimiter=",")
test_data = np.loadtxt(FILE_PATH+TEST_FILE_NAME, delimiter=",")

print("Mean of features: {}".format(mean_data))
print("Std of features: {}".format(std_data))
# Standardize (Preprocess) train and test data
for j in range(4):
    for i in range(train_data.shape[0]):
        train_data[i, j] = (train_data[i, j] - mean_data[j])/std_data[j]
    for i in range(test_data.shape[0]):
        test_data[i, j] = (test_data[i, j] - mean_data[j])/std_data[j]
# Convert scaled test and train data into PyTorch tensor
train_data = torch.Tensor(train_data)
test_data = torch.Tensor(test_data)
# Select device to compute cpu/gpu
device = torch.device('cpu')
batch_sz, D_in, H, D_out = 4, 4, 8, 3
# Use the nn package to define our model and loss function.
model = torch.nn.Sequential(
          torch.nn.Linear(D_in, H),
          torch.nn.ReLU(),
#           torch.nn.Linear(H, H),
#           torch.nn.ReLU(),
#           torch.nn.Linear(H, H),
#           torch.nn.ReLU(),
          torch.nn.Linear(H, D_out),
          torch.nn.Softmax(dim=0),
        )
# loss_fn = torch.nn.BCELoss()
# loss_fn = torch.nn.L1Loss(reduction='mean')
loss_fn = torch.nn.MSELoss(reduction='mean')
# loss_fn = torch.nn.PairwiseDistance(p=2)
# loss_fn = torch.nn.CrossEntropyLoss()

# Use the optim package to define an Optimizer that will update the weights of
# the model for us. Here we will use Adam; the optim package contains many other
# optimization algoriths. The first argument to the Adam constructor tells the
# optimizer which Tensors it should update.
learning_rate = 1e-4
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
# m = torch.nn.Sigmoid()
idx = np.arange(train_data.size()[0])
avg_loss_list = list()
epoch_list = list()
for epoch in range(200):
    total_loss = 0
    np.random.shuffle(idx)
    for id in idx:
#     for id in range(30):
        # Forward pass: compute predicted y by passing x to the model.
        y_pred = model(train_data[id,0:4])
        y = train_data[id,4:]
#         y_pred = model(train_data[batch_sz*id:batch_sz*(id+1), 0:4])
#         y = train_data[batch_sz*id:batch_sz*(id+1), 4:]

#         print ("Actual label: {}".format(y))
#         print("Predicted label: {}".format(y_pred))

        # Compute and print loss.
#         loss = loss_fn(m(y_pred), y)
        loss = loss_fn(y_pred, y)
#         print(t, loss.item())
        total_loss += loss

        # Before the backward pass, use the optimizer object to zero all of the
        # gradients for the Tensors it will update (which are the learnable weights
        # of the model)
        optimizer.zero_grad()

        # Backward pass: compute gradient of the loss with respect to model parameters
        loss.backward()

        # Calling the step function on an Optimizer makes an update to its parameters
        optimizer.step()

    avg_loss = total_loss/train_data.size()[0]
    avg_loss_list.append(avg_loss)
    epoch_list.append(epoch)
