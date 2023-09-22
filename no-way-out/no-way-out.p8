pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- no-way-out
-- by alexh95

function _init()
 p={x=1,y=1,d=0,sp=4,grab=false}
 c={x=60,y=16}
 b={{x=0,y=0},
    {x=4,y=4},
    {x=7,y=7},
    {x=6,y=7},
    {x=7,y=6}}
 lvl={x=8,y=8}
end

function _update60()
 nd=p.d
 np={x=p.x,y=p.y}
 if btnp(⬆️) then
  np.y-=1
  nd=1
 end
 if btnp(⬇️) then
  np.y+=1
  nd=3
 end
 if btnp(⬅️) then
  np.x-=1
  nd=2
 end
 if btnp(➡️) then
  np.x+=1
  nd=0
 end
 if validp(np) then
  p.x=np.x
  p.y=np.y
 end
 if btn(🅾️) then
  p.grab=true
 else
  p.grab=false
  p.d=nd
 end
 if btn(❎) then
  
 end
end

function validp(np)
 if not inbounds(np,lvl) then
  return false
 end
 if not noblock(np) then
  return false
 end
 return true
end

function noblock(np)
 for bl in all(b) do
  if bl.x==np.x and bl.y==np.y then
   return false
  end
 end
 return true
end

function pos(px,py,tx,ty)
 r={}
 r.x=px+tx*4-ty*4
 r.y=py+tx*4+ty*4
 return r
end

function posb(px,py,tx,ty)
 return pos(px,py,tx-1,ty-1)
end

function draw_grid()
 for i=0,lvl.x-1 do
  for j=0,lvl.y-1 do
   sp=pos(c.x,c.y,i,j)
   spr(33,sp.x,sp.y)
  end
 end
end

function draw_player()
 pp=posb(c.x,c.y,p.x,p.y)
 if p.d==0 then
  psp=36
 elseif p.d==1 then
  psp=4
 elseif p.d==2 then
  psp=5
 elseif p.d==3 then
  psp=37
 end
 if p.grab then
  psp+=2
 end
 spr(psp,pp.x,pp.y,1,2)
end

function draw_level()
 bo={}
 for bl in all(b) do
  index=bl.x+bl.y
  if bo[index]==nil then
   bo[index]={}
  end
  add(bo[index],bl)
 end

 for i=0,lvl.x+lvl.y do
  bol=bo[i]
  if bol!=nil then
   --print(i,7)
   for bl_i,bl in pairs(bol) do
    --print(bl,9)
    bp=posb(c.x,c.y,bl.x,bl.y)
    spr(16,bp.x,bp.y,1,2)
   end
  end
  if i==p.x+p.y then
   draw_player()
  end
 end
 
end

function _draw()
 cls()
 rect(0,0,127,127,1)
 print('no-way-out demo', 7)
 draw_grid()
 draw_level()
end
-->8
-- util
--

function inbounds(a,b)
 return a.x>=0 and a.x<b.x and
        a.y>=0 and a.y<b.y
end

function sorti(t)
 print(t[0],11)
 for n=2,#t do
  i=n
  while i>1 do
   t[i],t[i-1]=t[i-1],t[i]
   i-=1
  end
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000ff000000ff000000ff000000ff0000000000000000000000000000000000000000000000000000000000000000000
0070070000000000000000000000000000ffff0000ffff0000ffff0000ffff000000000000000000000000000000000000000000000000000000000000000000
00000000000550000005500000000000033ff000000ff330033ff000000ff3300000000000000000000000000000000000000000000000000000000000000000
000000000058850000588500000000000b333330033333b000333330033333000000000000000000000000000000000000000000000000000000000000000000
000000000588885005888850000ff0000b333330033333b00033333ff33333000000000000000005500000000000000000000005500000000000000000000000
00000000588888855888888500ffff000f3333b00b3333f000333300003333000000000000000058850000000000000000000058850000000000000000000000
00000000558888555588885500ffff0000b333b00b333b0000b3330000333b000000000000000588885000000000000000000588885000000000000000000000
000000005858858558588585033ff00000b3b3f00f3b3b0000b3b300003b3b000000000000005888888500000000000000005888888500000000000000000000
000550005885588558855885033333300066b300003b66000066b300003b66000000000000058888888850000000000000055888888550000000000000000000
0058850005885850058858500b333330000066000066000000006600006600000000000000558888888855000000000000588588885885000000000000000000
0588885000585500005855000b3333b0000000000000000000000000000000000000000000585888888585000000000005888858858888500000000000000000
5888888500055000000550000b3333b0000000000000000000000000000000000000000000588588885885000000000058888885588888850000000000000000
5588885500055000000050000bb333b0000000000000000000000000000000000000000000588858858885000000000055888855558888550000000000000000
58588585005005000005050000b3b3b0000000000000000000000000000000000000000000588885588885000000000058588585585885850000000000000000
58855885050000500050005000b3b300000000000000000000000000000000000000000000588888588885000000000058855885588558850000000000000000
58885885500000050500000500b3b300000000000000000000000000000000000000000000058888588850000000000058885885588858850000000000000000
5888588550000005500000500066b300000ff000000ff000000ff000000ff0000000000000005888588500000000000058885885588858850000000000000000
0588585005000050050005000000660000ffff0000ffff0000ffff0000ffff000000000000000588585000000000000005885850058858500000000000000000
00585500005005000050500000000000000ff330033ff000000ff330033ff0000000000000000058550000000000000000585500005855000000000000000000
00055000000550000005000000000000033339300393333003333930039333300000000000000005500000000000000000055000000550000000000000000000
00000000000000000000000000000000033393300339333003339330033933300000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000033933f00f3393300b33333ff33333b00000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000039333000033393000bf33000033fb000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000f333300003333f000333300003333000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000003366000066330000336600006633000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000006600000000660000660000000066000000000000000000000000000000000000000000000000000000000000000000
