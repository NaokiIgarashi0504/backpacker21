document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('prototype_title')){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };


    document.getElementById('prototype_title').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');
      
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      
      createImageHTML(blob);
    });
  }
});