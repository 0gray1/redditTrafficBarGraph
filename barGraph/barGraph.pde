// Reddit: u/d_mystery

// Variables below can be customized
String title = "Share of Reddit Traffic by Country"; // Set sliceMin to 1 to exclude US

int sliceMin = 0; // Top rank, starting from 0 (eg 0 -> united states at top, 1 -> UK at the top)
int sliceMax = 12; // Bottom rank, starting from 0, up to 25
float scale = 1; // Controls the size of the bar graph, default (scale=1) is 1600 * 900

// All of these control the size/position of the square that
// Contains all of the bars
float yMin = 100 * scale;
float yMax = 875 * scale;
float xMin = 150 * scale;
float xMax = 1525 * scale;

float padding = 10 * scale; // Space between bars (vertical)
float flagPadding = 4 * scale; // Space between the flag and the outside of the bar (horizontal & vertical)
float textPaddingLeft = 10 * scale; // Space between the country name text and the bar (horizontal)
float textPaddingRight = 5 * scale; // Space between the number of users text and the bar (horizontal)

int backgroundColor = 255;
boolean saveFile = true; // Save the image as png

// Don't touch these
float totalTraffic = 230.207640;
float highestUsers;
String[] countries;
PImage[] flags;
color[] flagColors;
Data data;

void settings() {
  int w = round(1600 * scale);
  int h = round(900 * scale);
  size(w, h);
}

void setup() {
  int sliceLength = sliceMax - sliceMin;
  data = new Data();
  countries = slice(data.keys(), sliceMin, sliceMax);
  flags = new PImage[sliceLength];
  flagColors = new color[sliceLength];
  for (int i = sliceMin; i < sliceMax; i++) {
    String country = countries[i-sliceMin];
    if (i == sliceMin) {
      highestUsers = data.get(country);
    }
    flags[i-sliceMin] = getFlag(country);
    flagColors[i-sliceMin] = averagePixelColor(flags[i-sliceMin]);
  }
}

void draw() {
  background(backgroundColor);
  noStroke();
  int size = sliceMax - sliceMin;
  float totalSpace = yMax - yMin;
  float maxWidth = xMax - xMin;
  float paddingSpace =  padding * size;
  float barSpace = totalSpace - paddingSpace;
  float barHeightTotal = totalSpace / size; // Height of bar including padding
  float barHeight = barSpace / size; // Height of bar excluding padding
  for (int i = 0; i < size; i++) {
    String country = countries[i];
    PImage flag = flags[i];
    color flagColor = flagColors[i];
    float users = data.get(country);
    float startY = barHeightTotal * i;
    float barWidth = maxWidth * users / highestUsers;
    
    // Bar rectangle
    fill(flagColor);
    rect(xMin, startY + yMin, barWidth, barHeight);
    
    float imWidth = flag.width;
    float imHeight = flag.height;
    float desiredHeight = barHeight - flagPadding * 2;
    float adjustedWidth = (desiredHeight / imHeight) * imWidth;
    
    float flagX = xMin + barWidth - adjustedWidth - flagPadding;
    float flagY = startY + yMin + flagPadding;
    
    // Flag
    fill(0);
    rect(flagX-1, flagY-1, adjustedWidth+2, desiredHeight+2);
    image(flag, flagX, flagY, adjustedWidth, desiredHeight);
    
    // So flags don't overflow past the edge
    fill(backgroundColor);
    rect(0, yMin + barHeightTotal * i, xMin, barHeightTotal);
    
    // Country name (on the left of the bar)
    fill(flagColor);
    textAlign(RIGHT, CENTER);
    textSize(18 * scale);
    if (country == "S.-Korea") {
      country = "South Korea";
    }
    if (country == "New-Zealand") {
      country = "New Zealand";
    }
    text(country, xMin - textPaddingLeft, startY + yMin + barHeight / 2 - 3 * scale);
    
    // Number of users (on the right of the bar)
    textAlign(LEFT, CENTER);
    textSize(12 * scale);
    // text(users + "M", xMin + barWidth + textPaddingRight, startY + yMin + barHeight / 2 - 3);
    // Round to nearest .1
    int percentInt = round((users / totalTraffic) * 1000);
    float percent = float(percentInt) / 10;
    text(percent + "%", xMin + barWidth + textPaddingRight, startY + yMin + barHeight / 2 - 3 * scale);
  }
  
  // Title
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(32 * scale);
  text(title, width / 2, yMin/2);
  
  if (saveFile) {
    saveFrame(title + ".png");
    saveFile = false;
  }
}

PImage getFlag(String country) {
  String path = "flags/flag-of-" + capitalize(country) + ".png";
  return loadImage(path);
}

color averagePixelColor(PImage image) {
  image.loadPixels();
  int num_pixels = image.pixels.length;
  float[] reds = new float[num_pixels];
  float[] greens = new float[num_pixels];
  float[] blues = new float[num_pixels];
  for (int loc = 0; loc < num_pixels; loc++) {
    reds[loc] = red(image.pixels[loc]);
    greens[loc] = green(image.pixels[loc]);
    blues[loc] = blue(image.pixels[loc]);
  }
  return color(mean(reds), mean(greens), mean(blues));
}

String capitalize(String s){
  return s.substring(0,1).toUpperCase()+s.substring(1,s.length());
}

String[] slice(String[] s, int sliceMin, int sliceMax) {
  int sliceLen = sliceMax - sliceMin;
  String[] res = new String[sliceLen];
  int counter = 0;
  for (int i = sliceMin; i < sliceMax; i++) {
    res[counter] = s[i];
    counter += 1;
  }
  return res;
}

float mean(float[] nums) {
  float sum = 0;
  for (int i = 0; i < nums.length; i++) {
    sum += nums[i];
  }
  return sum / nums.length;
}
