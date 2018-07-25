import coremltools

# Create model
coreml_model = coremltools.converters.keras.convert('dogsvscats.h5', input_names=['image'], output_names=['output'], image_input_names='image')

# Add metadata
coreml_model.author = 'AravindVasudev'
coreml_model.license = 'MIT'
coreml_model.short_description = 'A simple Dog or Cat classifier'
coreml_model.input_description['image'] = 'Digit image'
coreml_model.output_description['output'] = 'if image == dogs then 1 else 0'

# Print the model's structure
print(coreml_model)

# Save the model
coreml_model.save('dogsvscats.mlmodel')
