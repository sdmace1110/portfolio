from termcolor import colored, cprint
import time
import os

class Character:
    def __init__(self, name, init, hp, dead):
        self.name = name
        self.init = init
        self.hp = hp
        self.isdead = dead
        self.damagedone = 0
        self.damagetaken = 0
        self.healdone = 0
        self.healtaken = 0
        self.hasgone = False
        self.maxhp = hp
        self.kb = []
        self.numOfAttacks = 0

    def takedamage(self, amt):
        temp = self.hp
        self.hp = self.hp - amt
        print("The HP has changed from", temp, " to ", self.hp, " by taking damage: ", amt)

    def printplayer(self):
        cprint(self.name.upper(), 'yellow')
        print("Initiative:", colored(self.init, 'green'), colored("|", 'grey'), "Hit Points:", colored(self.hp, 'magenta'))
        cprint("_________________________________", 'grey')

    def printname(self):
        cprint(self.name.upper(), 'yellow')

    def fullprint(self):
        cprint(self.name.upper(), 'yellow')
        print("Initiative:", colored(self.init, 'green'), colored("|", 'grey'), "Hit Points:",
              colored(self.hp, 'magenta'),  colored("|", 'grey'), "Damage Done:", colored(self.damagedone, "blue"),
              colored("|", 'grey'), "Damage Taken:", colored(self.damagetaken, "cyan"),  colored("|", 'grey'), "Healing Recieved:", colored(self.healtaken, "red"), colored("|", 'grey'), "Healing Dealt:", colored(self.healdone, "yellow"), "Max HP:", self.maxhp, "Killing Blows:", self.kb, "Number of attacks:", self.numOfAttacks)
        cprint("_________________________________", 'grey')
        print("\n")


    def setinit(self, num):
        self.init = num

    def getinit(self):
        return self.init

    def setname(self, name):
        self.name = name

    def getname(self):
        return self.name

    def sethp(self, hp):
        self.hp = hp
        self.maxhp = self.hp

    def gethp(self):
        return self.hp

    def setdead(self):
        self.isdead = False

    def getdead(self):
        return self.isdead

    def died(self):
        self.isdead = True

    def dodmg(self, dmg):
        dmg = int(dmg)
        self.damagedone = self.damagedone + dmg

    def returndodmg(self):
        return self.damagedone

    def takedmg(self, dmg):
        dmg = int(dmg)
        self.damagetaken = self.damagetaken + dmg
        self.hp = self.hp - dmg

    def returntakedmg(self):
        return self.damagetaken

    def doheal(self, heal):
        heal = int(heal)
        self.healdone = self.healdone + heal

    def returndoheal(self):
        return self.healdone

    def takeheal(self, heal):
        heal = int(heal)
        self.healtaken = self.healtaken + heal
        self.hp = self.hp + heal
        if self.hp > self.maxhp:
            self.hp = self.maxhp

    def returntakeheal(self):
        return self.healdone

    def addattacknum(self):
        self.numOfAttacks += 1

    def addkb(self, whowaskilled):
        self.kb.append(whowaskilled)



# This function takes the player and monster array and returns
# a combined array of both groups; it's sorted by highest initiative
def combo_sort(players, mobs):
    # create returned array
    temp = []

    # Loops the number of elements in player array
    for s in players:
        temp.append(s)

    for t in mobs:
        temp.append(t)

    # Sort the combined array
    temp.sort(key=sortele, reverse=True)

    # Return the sorted array
    return temp


def sortele(val):
    return val.getinit()


def menu(pa, ma, ia, file):
    # Base case
    quitround = False
    while not quitround:
        print('\n\n', colored("----- MAIN MENU --------------------------------------------------------------------", 'red', 'on_grey'), '\n',
            colored("------------------------------------------------------------------------------------", 'grey'),
            "\n\n", colored('1', 'yellow'), "- Play ", colored('| ', 'grey'),
            colored('2', 'yellow'), " - Search  ", colored('| ', 'grey'),
            colored('3', 'yellow'), " - Edit ", colored('| ', 'grey'),
            colored('4', 'yellow'), " - Print Active List ", colored('| ', 'grey'),
            colored('5', 'yellow'), " - Exit \n\n",
            colored("--------------------------------------------------------------------", 'grey'), colored("iniTrack", 'red', 'on_grey'), colored("------\n", 'grey'),
            colored("------------------------------------------------------------------------------------", 'red', 'on_grey'), '\n\n')

        select = input("Please make your selection:\n")

        # ----------------------------------------- CONTINUE ROUND
        if select == '1':
            print("You selected one.  We will run a round.")
            one_round(pa, ma, ia, file)

        # ----------------------------------------- SEARCH
        elif select == '2':
            os.system('cls' if os.name == 'nt' else 'clear')
            donesearching = False
            while not donesearching:
                print(
                    colored("\n\n------", 'blue'), colored("Search", 'blue', 'on_grey'),  colored("--------------------------------------------------------------------", 'blue'), "\n\n",
                    colored('1', 'yellow'), "- By name ", colored('| ', 'grey'),
                    colored('2', 'yellow'), " - By lowest HPs ", colored('| ', 'grey'),
                    colored('3', 'yellow'), " - By initiative ", colored('| ', 'grey'),
                    colored('x', 'yellow'), " - Return to Main \n\n", colored("---------------------------------------------------------------------------------", 'grey', 'on_blue'),"\n\n")
                search = input("Type the appropriate letter to search: ")
                if search == '1':
                    searchname = input("What is the name you wish to search? ")
                    for p in pa:
                        if p.getname() == searchname:
                            p.fullprint()
                elif search == '2':
                    print("The player with the lowest hitpoints:\n\n ")
                    lowhp = 1000
                    holder = ""
                    for p in ia:
                        if p.gethp() <= lowhp:
                            lowhp = p.gethp()
                            holder = p.getname()
                    for p in ia:
                        if p.getname() == holder:
                            p.fullprint()

                    print("Search for lowest hitpoints.")
                elif search == '3':
                    highinit = 0
                    holder = ""
                    for i in ia:
                        if not i.getdead():
                            if i.getinit() > highinit:
                                highinit = i.getinit()
                                holder = i.getname()

                    for i in ia:
                        if i.getname() == holder:
                            i.fullprint()

                    print("Search by Initiative.")
                elif search == 'x':
                    donesearching = True
                else:
                    print("I don't understand your selection.  Please try again: ")

        # ----------------------------------------- EDIT
        elif select == '3':
            os.system('cls' if os.name == 'nt' else 'clear')
            doneediting = False
            while not doneediting:
                print("\n\n",
                    colored("------", 'green'), colored("Edit", 'green', 'on_grey'),
                    colored("-----------------------------------------------------------------------------------------------------------", 'green'), "\n\n",
                    colored('1', 'yellow'), "- Player Names ", colored('| ', 'grey'),
                    colored('2', 'yellow'), " - Mob Names", colored('| ', 'grey'),
                    colored('3', 'yellow'), " - Initiative list ", colored('| ', 'grey'),
                    colored('4', 'yellow'), " - Player HPs", colored('| ', 'grey'),
                    colored('5', 'yellow'), " - Mob HPs ", colored('| ', 'grey'),
                    colored('x', 'yellow'), " - Return to Main \n\n", colored("-----------------------------------------------------------------------------------------------------------------------", 'grey', 'on_green'), "\n\n")
                printer = input("Make your selections: ")
                if printer == '1':
                    selectname = input("Please select a Player to edit by typing their name: ")
                    replacename = input("What would you like to replace the name with? ")
                    check = 0
                    for p in pa:
                        if p.getname() == selectname:
                            p.setname(replacename)
                            p.printplayer()
                            print("Your change has been committed.")
                            check += 1
                    if check == 0:
                        print("We could not find the name you were looking for")
                elif printer == '2':
                    check = 0
                    selectname = input("Please select a Mob to edit by typing their name: ")
                    replacename = input("What would you like to replace the name with? ")
                    for m in ma:
                        if m.getname() == selectname:
                            m.setname(replacename)
                            m.printplayer()
                            print("Your change has been committed.")
                    if check == 0:
                        print("We could not find the name you were looking for")

                elif printer == '3':
                    selectname = input("Please select a character to edit by typing their name: ")
                    replaceinit = input("What would you like to change the initiation to? ")
                    #replaceinit = int(replaceinit)
                    check = 0
                    for c in ia:
                        if c.getname() == selectname:
                            c.setinit(replaceinit)
                            c.printplayer()
                            check += 1
                    if check == 0:
                        print("We could not find the name you were looking for")

                elif printer == '4':
                    check = 0
                    selectname = input("Please select a Player to edit by typing their hp: ")
                    replacehp = input("How many hit points to be reassigned? ")
                    for p in pa:
                        if p.getname() == selectname:
                            p.sethp(replacehp)
                            p.printplayer()
                            print("Your change has been committed.")
                    if check == 0:
                        print("We could not find the name you were looking for")
                elif printer == '5':
                    check = 0
                    selectname = input("Please select a Mob to edit by typing their name: ")
                    replacehp = input("What would you like to replace their hps to? ")
                    for m in ma:
                        if m.getname() == selectname:
                            m.sethp(replacehp)
                            m.printplayer()
                            print("Your change has been committed.")
                            check += 1
                    if check == 0:
                        print("We could not find the name you were looking for")
                elif printer == 'x':
                    doneediting = True
                else:
                    print("I don't understand your selection.  Please try again. ")

        # ----------------------------------------- PRINT
        elif select == '4':
            os.system('cls' if os.name == 'nt' else 'clear')
            doneprinting = False
            while not doneprinting:
                print("\n\n",
                    colored("------", 'magenta'), colored("Print", "magenta", "on_grey"),
                    colored("-------------------------------------------------------------------------------------------\n\n", 'magenta'),
                    colored('1', 'yellow'), "- Print Initiative list ", colored('| ', 'grey'),
                    colored('2', 'yellow'), " - Print Players' list ", colored('| ', 'grey'),
                    colored('3', 'yellow'), " - Print Mobs' list ", colored('| ', 'grey'),
                    colored('x', 'yellow'), " - Return to Main \n\n",
                    colored("--------------------------------------------------------------------------------------------------------", 'grey', 'on_magenta'),
                    "\n\n")
                printer = input("Make your selections: ")
                if printer == '1':
                    print("Printing Initiative List...")
                    for i in ia:
                        i.fullprint()
                elif printer == '2':
                    print("Printing Players' List...")
                    for p in pa:
                        p.printplayer()
                elif printer == '3':
                    print("Printing Mobs' List...")
                    for m in ma:
                        m.printplayer()
                elif printer == 'x':
                    doneprinting = True
                else:
                    print("I don't understand your selection.  Please try again. ")

        # ----------------------------------------- EXIT
        elif select == '5':
            print("Goodbye.")
            quitround = True
            os.system('cls' if os.name == 'nt' else 'clear')

        else:
            print("I'm not sure what you are requesting.  Please re-enter your selection.")


def one_round(plist, mlist, ilist, file):
    size = len(ilist)
    for x in range(size):
        if are_dead(plist) or are_dead(mlist):
            if are_dead(mArr):
                print("The rest of the initiative round has been cancelled.  All enemy mobs have been taken care of.\n")
            else:
                print("The rest of the initiative round has been cancelled.  Unfortunately, your entire group has died.\n")
        elif ilist[x].getdead():
            print(colored("Skipping", 'red'), ilist[x].getname(), colored("because they are dead.", 'red'), "\n")

        else:
            input("Press ENTER to continue... ")
            print("Next up............")
            ilist[x].printname()
            time.sleep(2)
            print("The clock begins now.  You have 30 seconds to decide a course of action.\n")
            #sleep_timer(ilist)
            battle_menu(ilist, ilist[x].getname(), plist, mlist, file)


def sleep_timer(arr):
    print()

def are_dead(arr):
    # initialize tracker which keep up with all the dead PC/NPC in list
    tracker = 0
    # Open list
    for c in arr:
        # Test if the element in list is true or false (dead or alive)
        # print(p, "Inside areDead()")
        if c.getdead():
            # If dead, increment tracker
            tracker += 1
    # Test if the entire group is dead
    # If tracker (num of dead) is same and list, then group is dead
    if tracker == len(arr):
        # print(tracker, "From if at the end....  Everyone is dead...")
        return True
    # If they aren't the same, then someone is still alive
    else:
        return False


def battle_menu(ilist, att_name, plist, mlist, file):
    # Get Updated head of INIT list

    att = input("0 - Missed Attack | 1 - Hit | 2 - Heal | 3 - Movement | 4 - Use a skill | m - Print Character list")
    tripped = False
    while not tripped:
        # ----------------------------- MISS ATTACK
        if att == '0':
            print(att_name, "missed!")
            file.write(att_name + " misses!\n")
            for x in ilist:
                if x.getname() == att_name:
                    x.addattacknum()


            tripped = True
        # ----------------------------- HIT ATTACK
        elif att == '1':
            hitnum = input("How many people were hit? 1 - One hit, 2 - Multiple hits, 0 - reset")
            hitnumint = int(hitnum)

            if hitnum == '1':
                dmgtarget = input("Who were you attacking? \n")
                dmg = input("how much damage was done on the sole recipient?\n  ")

                for x in ilist:
                    if x.getname() == dmgtarget:
                        x.takedmg(dmg)
                        file.write(att_name + " hits " + dmgtarget + " for " + dmg + "!\n")
                        if x.gethp() < 0:
                            x.died()
                            print(dmgtarget + " has died.")
                            file.write(dmgtarget + " has died.\n")
                            #x.fullprint()
                    if x.getname() == att_name:
                        x.dodmg(dmg)
                        x.addattacknum()
                        # x.fullprint()
            elif hitnumint >= 2:

                for y in range(hitnumint):
                    dmgtarget = input("Who is being attacked? \n")
                    dmg = input("how much damage was done? \n ")
                    for z in ilist:
                        if z.getname() == dmgtarget:
                            z.takedmg(dmg)
                            file.write(att_name + " hits " + dmgtarget + " for " + dmg + "!\n")
                            if z.gethp() < 0:
                                z.died()
                                print(dmgtarget + " has died.")
                                file.write(dmgtarget + " has died.\n")
                                for a in ilist:
                                    if a.getname() == att_name:
                                        a.addkb(dmgtarget)
                                #z.fullprint()
                        if z.getname() == att_name:
                            z.dodmg(dmg)
                            z.addattacknum()
                            #z.fullprint()
            elif hitnum == '0':
                att = input("0 - Missed Attack | 1 - Hit | 2 - Heal | 3 - Movement | 4 - Use a skill | 5 - Print Character list")

            tripped = True

        # ----------------------------- HEAL
        elif att == '2':
            # print(att_name, "healed someone!")
            more_heals = True
            while more_heals:
                healtarget = input("Who did they heal?\n")
                healamt = input("How much healing did they do?\n ")
                for x in ilist:
                    if x.getname() == healtarget:
                        x.takeheal(healamt)
                        x.fullprint()
                    if x.getname() == att_name:
                        x.doheal(healamt)
                        x.fullprint()


                end_loop = False
                while not end_loop:
                    more = input("Did anyone else get healed?  1 - yes, 2- no\n")
                    if more == "2":
                        more_heals = False
                        end_loop = True
                    elif more == '1':
                        f.write(att_name + " has healed " + healtarget + " for " + healamt + ".\n")
                        end_loop = True
                    else:
                        print("You missed keyed the response. \n ")

            tripped = True
        # ----------------------------- MOVEMENT
        elif att == '3':
            print(att_name, "moved!")
            print("Write to file (movement).")
            tripped = True
        # ----------------------------- Skill
        elif att == '4':
            print(att_name, "used a skill!")
            skill = input("What did they do? ")
            print("Write to file (skill).")
            tripped = True
        elif att == '5':
            cycle = len(ilist)
            for x in range(cycle):
                ilist[x].fullprint()
       # ----------------------------- TYPO ERROR CALL
        else:
            print("You typed a wrong response.")


# DRIVER SECTION
f = open("battle.txt", "w")

pArr = []
mArr = []

numPlayers = 7
numMobs = 2

basename = "p"

#p1 = Character("Michael", 0, 34, False)
p2 = Character("Burns", 0, 32, False)
p3 = Character("Teddy", 0, 31, False)
p4 = Character("Matt", 0, 25, False)
p5 = Character("Tommy", 0, 35, False)
p6 = Character("Phil", 0, 27, False)
p7 = Character("Fri", 0, 24, False)
p8 = Character("Nathan", 0, 29, False)

#pArr.append(p1)
pArr.append(p2)
pArr.append(p3)
pArr.append(p4)
pArr.append(p5)
pArr.append(p6)
pArr.append(p7)
pArr.append(p8)

m1 = Character("boar", 0, 42, False)
m2 = Character("rhino", 0, 45, False)

mArr.append(m1)
mArr.append(m2)

cArr = combo_sort(pArr, mArr)
# battle_menu(cArr, 'Bobby Hill', pArr, mArr, f)
menu(pArr, mArr, cArr, f)

f.close()



