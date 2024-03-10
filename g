<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hackathon</title>
</head>
<body>
    <h1>Welcome to the Hackathon</h1>
    <label for="page-select">Select a page:</label>
    <select id="page-select" onchange="navigate()">
        <option value="">Select Page</option>
        <option value="app.html">Crop Prediction</option>
    </select>

    <script>
        function navigate() {
            var selectedPage = document.getElementById("page-select").value;
            if (selectedPage) {
                window.location.href = selectedPage;
            }
        }
    </script>
</body>
</html>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://unpkg.com/axios@1.6.7/dist/axios.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <title>Crop Yield Prediction</title>
  <link rel="stylesheet" href="style.css">
  <style> 
    /* Additional CSS styles can be added here */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #333;
      color: #fff;
      padding: 20px;
      text-align: center;
    }

    main {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column; /* Align content vertically */
      min-height: 100vh; /* Ensure the main container takes at least the full height of the viewport */
    }

    .form-container {
      text-align: center;
      width: 60%; /* Adjust form container width */
    }

    label {
      display: block;
      margin-bottom: 10px;
    }

    input[type="text"], select {
      padding: 8px;
      width: 100%; /* Make inputs full width */
      margin-bottom: 20px;
    }

    button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    #map {
      height: 400px;
      width: 100%; /* Make the map container full width */
      margin-top: 20px;
    }

    div.container {
      text-align: center;
    }

  </style>
</head>
<body>
  <div class="container">
    <div class="card-block" id="formatted-address"></div>
    <div class="card-block" id="address-components"></div>
    <div class="card-block" id="geometry"></div>
  </div>
  <header>
    <h1>Crop Yield Prediction</h1>
  </header>

  <main>
    <!-- seasons -->
    <div class="season">
      <label for="Season">Season:</label>
      <select id="Season" name="Season">
        <option value="Winter">Winter</option>
        <option value="Spring">Spring</option>
        <option value="Summer">Summer</option>
        <option value="Autumn">Autumn</option>
      </select>
    </div>
    <div class="form-container">
      <form id="predictionForm">
        <label for="crop">Crop Type:</label>
        <select id="crop" name="crop">
          <option value="wheat">Wheat</option>
          <option value="corn">Corn</option>
          <option value="rice">Rice</option>
          <option value="soy">Soy</option>
          <!-- Add more crop options as needed -->
        </select>

        <label for="nitro">Nitrogen:</label>
        <input type="text" id="nitro" name="nitro" placeholder="Enter amount of nitrogen">

        <label for="Phospo">Phosphorous:</label>
        <input type="text" id="Phospo" name="phospo" placeholder="Enter amount of Phosphorous">

        <label for="K">Potassium:</label>
        <input type="text" id="K" name="pott" placeholder="Enter amount of Potassium">

        <hr> <!-- Grey line -->
      </form>
    </div>

    <div class="container">
      <label for="location">Location:</label>
      <form id="location-form">
        <input type="text" id="location-input" name="location" placeholder="Enter location">
        <br>
        <button type="submit">Predict</button>
      </form>
    </div>

    <div id="weather"></div>

    <div id="map"></div>

  </main>

  <script>
    function fetchWeather(location) {
      var apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
      var apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${apiKey}&units=metric`;

      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          var weatherDescription = data.weather[0].description;
          var temperature = data.main.temp;
          var humidity = data.main.humidity;
          var windSpeed = data.wind.speed;

          // Update the weather div with weather information
          document.getElementById('weather').innerHTML = `
            <h2>Weather Information for ${location}</h2>
            <p>Description: ${weatherDescription}</p>
            <p>Temperature: ${temperature}°C</p>
            <p>Humidity: ${humidity}%</p>
            <p>Wind Speed: ${windSpeed} m/s</p>
          `;

          // Update the map's center based on the provided location
          var lat = data.coord.lat;
          var lon = data.coord.lon;
          map.setCenter({ lat: lat, lng: lon });
          map.setZoom(10); // Set desired zoom level
        })
        .catch(error => {
          console.error('Error fetching weather data:', error);
        });
    }

  document.getElementById('predictionForm').addEventListener('submit', function(event) {
    event.preventDefault();
    var location = document.getElementById('location').value;
    fetchWeather(location);
  });
</script>


  <script>
    var map;
    function initMap() {
      map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 37.314469, lng: -120.481025 },
        zoom: 8
      });
    }
  </script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD2KTGfin5E4YZAXGfCXAjshZtXSMe4mYE&callback=initMap" async defer></script>
  <script>
    src="script.js"
  </script>
  <script>
    // geocode();

    //get location
    var locationForm = document.getElementById("location-form");

    // listen for submit
    locationForm.addEventListener('submit', geocode);

    function geocode(e){
      //Prevent actual submit
      e.preventDefault();

      var location = document.getElementById('location-input').value;
      axios.get('https://maps.googleapis.com/maps/api/geocode/json',{
        params:{
          address:location,
          key: 'AIzaSyD2KTGfin5E4YZAXGfCXAjshZtXSMe4mYE'
        }
      })
      .then(function(response){
        //log full response
        console.log(response);

        console.log(response.data.results[0].formatted_address)

        //formatted address
        var formattedAddress = response.data.results[0].formatted_address;
        var formattedAddressOutput = `
          <ul class="list-group">
            <li class="list-group-item">${formattedAddress}</li>
          </ul>
        `;

        console.log(response.data.results[0].formatted_address)
        
        //ADDRESS COMPONENTS
        var addressComponents = response.data.results[0].address_components;
        var addressComponentsOutput = '<ul class="list-group">';
        for(var i = 0; i < addressComponents.length; i++){
          addressComponentsOutput += `
            <li class="list-group-item"><strong>${addressComponents[i].types[0]}</strong>: ${addressComponents[i].long_name}</li>
          `;
        }
        addressComponentsOutput += '</ul>';

        // Geometry
        var lat = response.data.results[0].geometry.location.lat;
        var lng = response.data.results[0].geometry.location.lng;
        var geometryOutput = `
          <ul class="list-group">
            <li class="list-group-item"><strong>Latitude</strong>: ${lat}</li>
            <li class="list-group-item"><strong>Longitude</strong>: ${lng}</li>
          </ul>
        `;


        // Output to app
        document.getElementById('formatted-address').innerHTML = formattedAddressOutput;

        document.getElementById('address-components').innerHTML = addressComponentsOutput;
        
        document.getElementById("geometry").innerHTML = geometryOutput;
      })
      .catch(function(error){
        console.log(error);
      });
      
    }
  </script>
</body>
</html>


