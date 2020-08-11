/*

 HOT DOG Linux

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdoglinux.com

 This file is part of HOT DOG Linux.

 HOT DOG Linux is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "HOTDOG.h"

@implementation Definitions(fjeiowjfklsdjfkldsjlkfj)
+ (char *)cStringForCheckbox
{
    return
"bbbbbbbbbbbb\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"bbbbbbbbbbbb\n"
;
}
+ (char *)cStringForCheckboxSelected
{
    return
"bbbbbbbbbbbb\n"
"bb        bb\n"
"b b      b b\n"
"b  b    b  b\n"
"b   b  b   b\n"
"b    bb    b\n"
"b    bb    b\n"
"b   b  b   b\n"
"b  b    b  b\n"
"b b      b b\n"
"bb        bb\n"
"bbbbbbbbbbbb\n"
;
}
+ (char *)cStringForCheckboxDown
{
    return
"bbbbbbbbbbbb\n"
"bbbbbbbbbbbb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bbbbbbbbbbbb\n"
"bbbbbbbbbbbb\n"
;
}
@end

@interface Checkbox : IvarObject
{
    BOOL _checked;
    BOOL _down;
    BOOL _hover;
}
@end
@implementation Checkbox
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    char *button = [Definitions cStringForCheckbox];
    char *selected = [Definitions cStringForCheckboxSelected];
    char *down = [Definitions cStringForCheckboxDown];
    int width = [Definitions widthForCString:button];
    int height = [Definitions heightForCString:button];
    int x = (r.w - width) / 2;
    int y = (r.h - height) / 2;
    char *str = button;
    if (_down && _hover) {
        str = down;
    }
    [bitmap drawCString:str x:x y:y c:'b' r:0 g:0 b:0 a:255];
    if (_checked) {
        [bitmap drawCString:selected x:x y:y c:'b' r:0 g:0 b:0 a:255];
    }
}
- (void)handleMouseDown:(id)event
{
    _down = YES;
    _hover = YES;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    if ((mouseX < 0) || (mouseX >= viewWidth)) {
        _hover = NO;
        return;
    }
    if ((mouseY < 0) || (mouseY >= viewHeight)) {
        _hover = NO;
        return;
    }
    _hover = YES;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_hover) {
        _checked = (_checked) ? NO : YES;
    }
    _down = NO;
}
@end

