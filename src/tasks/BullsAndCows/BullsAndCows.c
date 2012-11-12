#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdbool.h>
#include <curses.h>
#include <string.h>
 
#define MAX_NUM_TRIES 72
#define LINE_BEGIN 7
#define LAST_LINE 18
 
int yp=LINE_BEGIN, xp=0;
 
char number[5];
char guess[5];
 
#define MAX_STR 256
void mvaddstrf(int y, int x, const char *fmt, ...)
{
  va_list args;
  char buf[MAX_STR];
 
  va_start(args, fmt);
  vsprintf(buf, fmt, args);
  move(y, x);
  clrtoeol();
  addstr(buf);
  va_end(args);
}
 
void ask_for_a_number()
{
  int i=0;
  char symbols[] = "123456789";
 
  move(5,0); clrtoeol();
  addstr("Enter four digits: ");
  while(i<4) {
    int c = getch();
    if ( (c >= '1') && (c <= '9') && (symbols[c-'1']!=0) ) {
      addch(c);
      symbols[c-'1'] = 0;
      guess[i++] = c;
    }
  }
}
 
void choose_the_number()
{
  int i=0, j;
  char symbols[] = "123456789";
 
  while(i<4) {
    j = rand() % 9;
    if ( symbols[j] != 0 ) {
      number[i++] = symbols[j];
      symbols[j] = 0;
    }
  }
}

bool take_it_or_not()
{
  int i;
  int cows=0, bulls=0;
 
  for(i=0; i < 4; i++) {
    if ( number[i] == guess[i] ) {
      bulls++;
    } else if ( strchr(number, guess[i]) != NULL ) {
      cows++;
    }
  }
  move(yp, xp);
  addstr(guess); addch(' ');
  if ( bulls == 4 ) { yp++; return true; }
  if ( (cows==0) && (bulls==0) ) addch('-');
  while( cows-- > 0 ) addstr("O");
  while( bulls-- > 0 ) addstr("X");
  yp++;
  if ( yp > LAST_LINE ) {
    yp = LINE_BEGIN;
    xp += 10;
  }
  return false;
}
 
bool ask_play_again()
{
  int i;
 
  while(yp-- >= LINE_BEGIN) {
    move(yp, 0); clrtoeol();
  }
  yp = LINE_BEGIN; xp = 0;
 
  move(21,0); clrtoeol();
  addstr("Do you want to play again? [y/n]");
  while(true) {
    int a = getch();
    switch(a) {
    case 'y':
    case 'Y':
      return true;
    case 'n':
    case 'N':
      return false;
    }
  }
}
 
 
int main()
{
  bool bingo, again;
  int tries = 0;
 
  initscr(); cbreak(); noecho();
  clear();
 
  number[4] = guess[4] = 0;
 
  mvaddstr(0,0, "I choose a number made of 4 digits (from 1 to 9) without repetitions\n"
                "You enter a number of 4 digits, and I say you how many of them are\n"
                "in my secret number but in wrong position (cows or O), and how many\n"
                "are in the right position (bulls or X)");
  do {
    move(20,0); clrtoeol(); move(21, 0); clrtoeol();
    srand(time(NULL));
    choose_the_number();
    do {
      ask_for_a_number();
      bingo = take_it_or_not();
      tries++;
    } while(!bingo && (tries < MAX_NUM_TRIES));
    if ( bingo ) 
      mvaddstrf(20, 0, "You guessed %s correctly in %d attempts!", number, tries);
    else
      mvaddstrf(20,0, "Sorry, you had only %d tries...; the number was %s", 
		MAX_NUM_TRIES, number);
    again = ask_play_again();
    tries = 0; 
  } while(again);
  nocbreak(); echo(); endwin();
  return EXIT_SUCCESS;
}