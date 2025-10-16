@echo off
if not exist main-.c goto nofiles
echo compiling with WATCOM
echo main-.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-.c
echo main-0.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-0.c
echo main-1.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-1.c
echo main-2.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-2.c
echo main-3.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-3.c
echo main-4.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-4.c
echo main-5.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-5.c
echo main-6.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-6.c
echo main-7.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s main-7.c
echo openworld.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s openworld.c
echo openwo_0d.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s openwo_0d.c
echo openwo_1d.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s openwo_1d.c
echo eugl.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s eugl.c
echo machine.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s machine.c
echo dll.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s dll.c
echo get.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s get.c
echo msgbox.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s msgbox.c
echo misc.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s misc.c
echo ewin32api.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s ewin32api.c
echo gl.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s gl.c
echo glu.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s glu.c
echo winbmp.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s winbmp.c
echo file.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s file.c
echo sort.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s sort.c
echo database.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s database.c
echo light.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s light.c
echo d3d.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s d3d.c
echo d3d_0.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s d3d_0.c
echo texture.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s texture.c
echo spritesheet.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s spritesheet.c
echo font.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s font.c
echo extra.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s extra.c
echo hash.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s hash.c
echo objects.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s objects.c
echo projectile.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s projectile.c
echo projectile_enemy.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s projectile_enemy.c
echo tinyxml.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s tinyxml.c
echo win32lib.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32lib.c
echo win32l_0.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_0.c
echo win32l_1.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_1.c
echo win32l_2.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_2.c
echo win32l_3.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_3.c
echo win32l_4.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_4.c
echo win32l_5.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_5.c
echo win32l_6.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_6.c
echo win32l_7.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_7.c
echo win32l_8.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_8.c
echo win32l_9.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_9.c
echo win32l_A.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_A.c
echo win32l_B.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_B.c
echo win32l_C.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_C.c
echo win32l_D.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_D.c
echo win32l_E.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_E.c
echo win32l_F.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_F.c
echo win32l_G.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s win32l_G.c
echo wildcard.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s wildcard.c
echo w32msgs.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32msgs.c
echo w32support.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32support.c
echo w32sup_0rt.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32sup_0rt.c
echo w32sup_1rt.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32sup_1rt.c
echo w32dll.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32dll.c
echo w32file.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s w32file.c
echo series.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s series.c
echo rttext.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s rttext.c
echo options.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s options.c
echo groundxml.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s groundxml.c
echo equipxml.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s equipxml.c
echo xmlall.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s xmlall.c
echo xmlall_0.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s xmlall_0.c
echo projectilexml.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s projectilexml.c
echo wmap.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s wmap.c
echo zlib.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s zlib.c
echo input_stream.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s input_stream.c
echo player.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s player.c
echo button.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s button.c
echo lootbag.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s lootbag.c
echo grid.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s grid.c
echo enemy.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s enemy.c
echo init-.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s init-.c
echo init-0.c
wcc386 /bt=nt /mf /w0 /zq /j /zp4 /fp5 /fpi87 /5r /otimra /s init-0.c
echo linking
wlink FILE openworld.obj @objfiles.lnk
del *.obj > NUL
if not exist openworld.exe goto done
echo you can now execute: openworld.exe
del main-.c
del main-.h
del init-.c
del main-0.c
del main-1.c
del main-2.c
del main-3.c
del main-4.c
del main-5.c
del main-6.c
del main-7.c
del objfiles.lnk
del openworld.c
del openwo_0d.c
del openwo_1d.c
del eugl.c
del machine.c
del dll.c
del get.c
del msgbox.c
del misc.c
del ewin32api.c
del gl.c
del glu.c
del winbmp.c
del file.c
del sort.c
del database.c
del light.c
del d3d.c
del d3d_0.c
del texture.c
del spritesheet.c
del font.c
del extra.c
del hash.c
del objects.c
del projectile.c
del projectile_enemy.c
del tinyxml.c
del win32lib.c
del win32l_0.c
del win32l_1.c
del win32l_2.c
del win32l_3.c
del win32l_4.c
del win32l_5.c
del win32l_6.c
del win32l_7.c
del win32l_8.c
del win32l_9.c
del win32l_a.c
del win32l_b.c
del win32l_c.c
del win32l_d.c
del win32l_e.c
del win32l_f.c
del win32l_g.c
del wildcard.c
del w32msgs.c
del w32support.c
del w32sup_0rt.c
del w32sup_1rt.c
del w32dll.c
del w32file.c
del series.c
del rttext.c
del options.c
del groundxml.c
del equipxml.c
del xmlall.c
del xmlall_0.c
del projectilexml.c
del wmap.c
del zlib.c
del input_stream.c
del player.c
del button.c
del lootbag.c
del grid.c
del enemy.c
del init-0.c
goto done
:nofiles
echo Run the translator to create new .c files
:done
