### Requirements

i3 windows manager :

* i3
* i3blocks
* i3lock
* lightdm

Debian user

	sudo apt-get install lightdm i3 i3blocks i3lock

font and icons :

[FontAwesome](http://kumarcode.com/resources/fontawesome-webfont.ttf)

[ArchIcon](http://kumarcode.com/resources/AIcons.ttf)

[Clock&Temp Icons](http://kumarcode.com/resources/icons.ttf)

### Font Installation

	mkdir ~/.local/share/fonts
	cp *.ttf ~/.local/share/fonts
	fc-cache -fv

### Installation

	git clone https://github.com/Rigonkmalk/dotfiles.git && cd dotfiles/i3
	cp * ~/.i3/

restart i3, done !
