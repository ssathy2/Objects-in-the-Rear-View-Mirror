/* Class file for the filter menu buttons, linegraph button, map graph button, help button, national comparison button, and any other
part of the general ui */
float timeSliderLeft, timeSliderRight, timeSliderTop, timeSliderBottom, timeSliderLowLeft, timeSliderButtonTop, timeSliderButtonBottom, timeSliderLowRight, timeSliderHighLeft, timeSliderHighRight, mouseXOld;

boolean timeSliderLowMove = false;
boolean timeSliderHighMove = false;

void drawTimeSlider(){
  if(timeSliderLowMove){
    if (mouseX - mouseXOld < timeSliderHighLeft - timeSliderLowRight && mouseX <= timeSliderRight && mouseX >= timeSliderLeft){
      timeSliderLowLeft += mouseX - mouseXOld;
      timeSliderLowRight += mouseX - mouseXOld;
      mouseXOld = mouseX;
    }
  }
  if(timeSliderHighMove){
    if (mouseX - mouseXOld > timeSliderLowRight - timeSliderHighLeft && mouseX <= timeSliderRight && mouseX >= timeSliderLeft){
      timeSliderHighLeft += mouseX - mouseXOld;
      timeSliderHighRight += mouseX - mouseXOld;
      mouseXOld = mouseX;
    }
  }
  fill(40);
  rectMode(CORNERS);
  rect(timeSliderLeft, timeSliderTop, timeSliderRight, timeSliderBottom);
  fill(50);
  rect(timeSliderLowLeft, timeSliderButtonTop, timeSliderLowRight, timeSliderButtonBottom);
  rect(timeSliderHighLeft, timeSliderButtonTop, timeSliderHighRight, timeSliderButtonBottom);
  fill(#9400D3);
  rect(timeSliderLowRight, timeSliderButtonTop + 15*scaleFactor, timeSliderHighLeft, timeSliderButtonBottom-15*scaleFactor);
  
  rectMode(CORNER);
  fill(255);
  rect(timesliderLowLeft - 10*scaleFactor, timeSliderButtonTop + 20*scaleFactor, timeSliderLowRight + 10*scaleFactor, timeSliderButtonTop + 10*scaleFactor);
}
