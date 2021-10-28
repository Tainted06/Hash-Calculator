import tkinter as tk

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

window.mainloop()