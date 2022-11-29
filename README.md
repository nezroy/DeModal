# DeModal

**DeModal** disables WoW's modal style, panel-based, automatic window management for a number of default UI windows. It allows these windows to be moved and stacked by the user like a modern window-based UI. 

Blizzard opted to automatically manage UI panels in a very limited fashion to control the UI on small resolutions, restricting the total number of panels that can be displayed at once and enforcing automatic positioning. With modern resolutions and window-based sensibilities, this automatic panel management now feels clunky and unnecessary.

The WoW API contains all of the underlying code needed to handle user-based window placement. It is simply not enabled for most of the default UI panels. This addon enables this built-in functionality where possible. It does not re-write or replace ANY of the default UI elements so it should remain very lightweight and widely compatible.

⸻

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

⸻

### SETTINGS

Settings are found in the default AddOn options location: `ESC → Options → AddOns → DeModal`.

  - **Save windows only for this character**: check this to save window settings only for the current character. If unchecked (default) the current character will share saved window settings with all characters.
  - **Reset All Saved Window Settings**: click to reset all saved window settings in the current character and shared profiles. Forces a UI reload.
  - **Merge quest, gossip, and merchant frames**: check this (default) to prevent certain frames being open at the same time, as well as to use a common position for them. This fixes some bugs caused by the Blizz UI not expecting some windows to ever be open together. For example, a gossip frame offering multiple quests doesn't always update correctly after accepting or completing a quest. Left this as an option for those who, because of other addons or whatever reason, want to keep the legacy behavior of having these completely separate, even with the possible bugginess.

⸻

### BLIZZMOVE

Isn't this just [BlizzMove](https://www.curseforge.com/wow/addons/blizzmove)? They are similar, but BlizzMove does not fully disable the automatic panel management and does not allow unlimited panels to be open at once. For example, you cannot have the Adventure Guide and Map open at the same time in the default WoW UI *or* with BlizzMove.

⸻

### KNOWN ISSUES

The "Guild & Communities" window being movable broke as of 10.0.0. Support for moving this panel has been disabled until I can determine the cause.

When certain protected panels are opened for the first time while in combat, DeModal cannot initially modify their behavior. These windows should get properly DeModal-fied once exiting combat. This is working as intended and is a fundamental limitation of working with protected frames in the WoW API.

⸻

### TROUBLESHOOTING

If you encounter any serious bugs or missing windows you can try resetting your saved window positions from the settings menu.

If you encounter issues and used a version of DeModal prior to 0.7.0, you can also try deleting the layout cache. Do this by logging out of Warcraft and then deleting the [layout-local.txt](https://wowpedia.fandom.com/wiki/Layout-local.txt) file from your WTF cache.

⸻

### SCREENSHOTS
![A bunch of overlapping windows](https://github.com/nezroy/DeModal/blob/main/screenshots/lots_of_windows.jpg?raw=true)
![Adventure Guide and Map at the same time? Now you can!](https://github.com/nezroy/DeModal/blob/main/screenshots/adventure_guide_and_map.jpg?raw=true)
![Look at collections and profession recipes while shopping on the auction house](https://github.com/nezroy/DeModal/blob/main/screenshots/collection_profession_auction.jpg?raw=true)
![TBC windows](https://github.com/nezroy/DeModal/blob/main/screenshots/tbc_windows.jpg?raw=true)
