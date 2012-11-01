/* Class file for the filter menu buttons, linegraph button, map graph button, help button, national comparison button, and any other
part of the general ui */
float timeSliderLeft, timeSliderRight, timeSliderTop, timeSliderBottom, timeSliderLowLeft, timeSliderButtonTop, timeSliderButtonBottom, timeSliderLowRight, timeSliderHighLeft, timeSliderHighRight, mouseXOld;

boolean timeSliderLowMove = false;
boolean timeSliderHighMove = false;

void drawTimeSlider(){
  strokeWeight(0);
  if(timeSliderLowMove && mouseX - mouseXOld < timeSliderHighLeft - timeSliderLowRight && timeSliderLowRight + mouseX - mouseXOld >= timeSliderLeft){
    timeSliderLowLeft += mouseX - mouseXOld;
    timeSliderLowRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }
  if(timeSliderHighMove && mouseX - mouseXOld > timeSliderLowRight - timeSliderHighLeft && timeSliderHighLeft + mouseX - mouseXOld <= timeSliderRight){
    timeSliderHighLeft += mouseX - mouseXOld;
    timeSliderHighRight += mouseX - mouseXOld;
    mouseXOld = mouseX;
  }
  fill(40);
  rectMode(CORNERS);
  rect(timeSliderLeft, timeSliderTop, timeSliderRight, timeSliderBottom);
  fill(50);
  rect(timeSliderLowLeft, timeSliderButtonTop, timeSliderLowRight, timeSliderButtonBottom);
  rect(timeSliderHighLeft, timeSliderButtonTop, timeSliderHighRight, timeSliderButtonBottom);
  fill(#FA8A11);
  rect(timeSliderLowRight, timeSliderButtonTop + 15*scaleFactor, timeSliderHighLeft, timeSliderButtonBottom-15*scaleFactor);
  
  fill(0);
  rect(timeSliderLowLeft - 30*scaleFactor, timeSliderButtonTop - 25*scaleFactor, timeSliderLowRight, timeSliderButtonTop - 5*scaleFactor);
  rect(timeSliderHighLeft, timeSliderButtonTop - 25*scaleFactor, timeSliderHighRight + 30*scaleFactor, timeSliderButtonTop - 5*scaleFactor);
  fill(240);
  textAlign(CENTER);
  textSize(12*scaleFactor);
  text(Math.round((timeSliderLowRight - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*100) + "%", timeSliderLowRight - 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
  text(Math.round((timeSliderHighLeft - timeSliderLeft)/(timeSliderRight - timeSliderLeft)*100) + "%", timeSliderHighLeft + 22*scaleFactor, timeSliderButtonTop - 10*scaleFactor);
}
