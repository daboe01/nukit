/*
* Copyright (c) 2016, Alcatel-Lucent Inc
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of the copyright holder nor the names of its contributors
*       may be used to endorse or promote products derived from this software without
*       specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

@import <Foundation/Foundation.j>
@import "NUAbstractDataView.j"


@implementation NULibraryItemDataView : NUAbstractDataView
{
    @outlet CPTextField     fieldName;
    @outlet CPTextField     fieldDescription;
    @outlet CPImageView     imageViewIcon;
}


#pragma mark -
#pragma mark Data View Protocol

- (void)setObjectValue:(id)anObject
{
    _objectValue = anObject;

    [fieldName bind:CPValueBinding toObject:anObject withKeyPath:@"name" options:nil];
    [fieldDescription bind:CPValueBinding toObject:anObject withKeyPath:@"description" options:nil];
    [imageViewIcon bind:CPValueBinding toObject:anObject withKeyPath:@"icon" options:nil];

    _cucappID(self, [_objectValue name]);
}

#pragma mark -
#pragma mark Overrides

- (void)draggingImageView
{
    var enclosingView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)],
        view = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)],
        iconView = [[CPImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32, 32)];

    [iconView setCenter:[view center]];
    [iconView setImage:[imageViewIcon image]];
    [view setBackgroundColor:NUSkinColorGreyLighter];
    [view addSubview:iconView];
    [view setClipsToBounds:NO];

    [view setInAnimation:@"scaleIn" duration:0.15];
    view._DOMElement.style.borderRadius = "100px";
    view._DOMElement.style.border = "3px solid #5385D5";
    view._DOMElement.style.boxShadow = "0px 0px 10px gray";

    [view setCenter:[enclosingView center]];
    [enclosingView addSubview:view];
    [enclosingView setAlphaValue:0.9];

    return enclosingView;
}


#pragma mark -
#pragma mark CPCoding compliance

- (id)initWithCoder:(CPCoder)aCoder
{
    if (self = [super initWithCoder:aCoder])
    {
        fieldName        = [aCoder decodeObjectForKey:@"fieldName"];
        fieldDescription = [aCoder decodeObjectForKey:@"fieldDescription"];
        imageViewIcon    = [aCoder decodeObjectForKey:@"imageViewIcon"];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:fieldName forKey:@"fieldName"];
    [aCoder encodeObject:fieldDescription forKey:@"fieldDescription"];
    [aCoder encodeObject:imageViewIcon forKey:@"imageViewIcon"];
}

@end
