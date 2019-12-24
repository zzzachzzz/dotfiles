import readline
import pdb

# Configuration file for pdb++ based on the author's own config
class Config(pdb.DefaultConfig):
    editor = 'e'
    stdin_paste = 'epaste'
    filename_color = pdb.Color.lightgray
    use_terminal256formatter = False

    def __init__(self):
        try:
            from pygments.formatters import terminal
        except ImportError:
            pass
        else:
            self.colorscheme = terminal.TERMINAL_COLORS.copy()
            self.colorscheme.update({
                terminal.Keyword:            ('darkred',     'red'),
                terminal.Number:             ('darkyellow',  'yellow'),
                terminal.String:             ('brown',       'green'),
                terminal.Name.Function:      ('darkgreen',   'blue'),
                terminal.Name.Namespace:     ('teal',        'turquoise'),
                })
            self.sticky_by_default = True

    def setup(self, pdb):
        Pdb = pdb.__class__
        Pdb.do_l = Pdb.do_longlist  # Make 'l' an alias to 'longlist'
        Pdb.do_st = Pdb.do_sticky

