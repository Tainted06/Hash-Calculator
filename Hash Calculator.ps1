import tkinter as tk
from tkinter import *

# Window
window = tk.Tk()
window.title('Python Hash Calculator Made By Tainted | https://github.com/Tainted06/Hash-Calculator')
window_width = 700
window_height = 275
screen_width = window.winfo_screenwidth()
screen_height = window.winfo_screenheight()
center_x = int(screen_width/2 - window_width / 2)
center_y = int(screen_height/2 - window_height / 2)
window.geometry(f'{window_width}x{window_height}+{center_x}+{center_y}')
window.resizable(False, False)
# Window

# Text Boxes and Buttons
text1 = Text(window, width=75, height=1, yscrollcommand=set())
text1.insert(INSERT, "File Location...")
text1.pack(padx=1, side=tk.LEFT, pady=130)

# Text Boxes and Buttons


window.mainloop()