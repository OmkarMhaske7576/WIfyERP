<html>
<body style="overflow-x: auto">
<h1>Upload new Photo</h1>
    <form method="POST" action="/addPhotoForm" enctype="multipart/form-data">
    Title:<input type="text" name="title" />
    <br>
    Image:<input type="file" name="image" accept="image/*" />
    <br>
    <input type="submit" value="Upload" />
</form>
</body>
</html>