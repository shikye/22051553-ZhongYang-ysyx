#include <NDL.h>
#include <sdl-timer.h>
#include <stdio.h>

SDL_TimerID SDL_AddTimer(uint32_t interval, SDL_NewTimerCallback callback, void *param) {
  printf("hh\n");
  return NULL;
}

int SDL_RemoveTimer(SDL_TimerID id) {
  return 1;
}

uint32_t SDL_GetTicks() {  //消耗时间不短
  return NDL_GetTicks();
}

void SDL_Delay(uint32_t ms) {
}
