const api = {
  key: "b3b3efd2334a9139b4a46178b87e4f5f",
  base: "https://api.openweathermap.org/data/2.5/",
};

const searchbox = document.querySelector(".search");
searchbox.addEventListener("keypress", setQuery);

function getResults(b) {
  fetch(`${api.base}weather?q=${b}&units=metric&APPID=${api.key}`)
    .then((weather) => {
      console.log(weather);
      return weather.json();
    })
    .then(displayResults);
}

function setQuery(a) {
  if (a.keyCode == 13) {
    getResults(searchbox.value);
  }
}

function displayResults(weather) {
  let city = document.querySelector(".location .city");
  city.innerText = `${weather.name}, ${weather.sys.country}`;

  let now = new Date();
  let date = document.querySelector(".location .date");
  date.innerText = dateBuilder(now);

  let temp = document.querySelector(".current .temp");
  temp.innerHTML = `${Math.round(weather.main.temp)}<span>°C</span>`;

  let atmosp = document.querySelector(".current .weather");
  atmosp.innerText = weather.weather[0].main;

  let humid = document.querySelector(".current .humidity");
  humid.innerHTML = weather.main.humidity;

  let hi_lo = document.querySelector(".hi-low");
  hi_lo.innerText = `${Math.round(weather.main.temp_max)}°C / ${Math.round(
    weather.main.temp_min
  )}°C`;

  let icon = document.getElementById("icon");
  icon.src =
    "http://openweathermap.org/img/wn/" + weather.weather[0].icon + ".png";
}

function dateBuilder(d) {
  let months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  let days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  let day = days[d.getDay()];
  let date = d.getDate();
  let month = months[d.getMonth()];
  let year = d.getFullYear();
  return `${day} ${date} ${month} ${year}`;
}
