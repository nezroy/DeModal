# DeModal

**DeModal** disables WoW's modal style, panel-based, automatic window management for a number of default UI windows. It allows these windows to be moved and stacked by the user like a modern window-based UI. 

Blizzard opted to automatically manage UI panels in a very limited fashion to control the UI on small resolutions, restricting the total number of panels that can be displayed at once and enforcing automatic positioning. With modern resolutions and window-based sensibilities, this automatic panel management now feels clunky and unnecessary.

The WoW API contains all of the underlying code needed to handle user-based window placement. It is simply not enabled for most of the default UI panels. This addon enables this built-in functionality where possible. It does not re-write or replace ANY of the default UI elements so it should remain very lightweight and widely compatible.

### MOVABLE WINDOWS
  
  - Character, Spellbook, Spec and Talents
  - Merchants, Auction House
  - Bank Vault, Guild Bank, Void Storage
  - NPC/Quest Dialog, Trainers
  - Group Finder, Adventure Guide, Map and Quest Log
  - Guild, Communities, Mailbox, Friends List
  - Achievements, Calendar
  - Dressing Room, Inspect, Transmogrify, Collections
  - Garrison, Order Hall, Covenant, Soulbinds
  - more...

The goal is to let you move anything that *looks like* a movable UI window (e.g. panels with a well-defined frame or title bar). It is not for moving intrinsic UI elements like tooltips, action bars, talking heads, unit frames, etc.

### SETTINGS

There are no settings.

### BLIZZMOVE

Isn't this just [BlizzMove](https://www.curseforge.com/wow/addons/blizzmove)? They are similar, but BlizzMove does not fully disable the automatic panel management and does not allow unlimited panels to be open at once. For example, you cannot have the Adventure Guide and Map open at the same time in the default WoW UI *or* with BlizzMove.

### KNOWN ISSUES

When certain protected panels are opened for the first time while in combat, DeModal cannot initially modify their behavior. These windows should get properly DeModal-fied once exiting combat. This is working as intended and is a fundamental limitation of working with protected frames in the WoW API.

### TROUBLESHOOTING

If you encounter any serious bugs or missing windows you can try resetting your saved window positions. Do this by logging out of Warcraft and then deleting the [layout-local.txt](https://wowpedia.fandom.com/wiki/Layout-local.txt) file from your WTF cache.

### SCREENSHOTS
![A bunch of overlapping windows](https://github.com/nezroy/DeModal/blob/main/screenshots/lots_of_windows.jpg?raw=true)
![Adventure Guide and Map at the same time? Now you can!](https://github.com/nezroy/DeModal/blob/main/screenshots/adventure_guide_and_map.jpg?raw=true)
![Look at collections and profession recipes while shopping on the auction house](https://github.com/nezroy/DeModal/blob/main/screenshots/collection_profession_auction.jpg?raw=true)
![TBC windows](https://github.com/nezroy/DeModal/blob/main/screenshots/tbc_windows.jpg?raw=true)
