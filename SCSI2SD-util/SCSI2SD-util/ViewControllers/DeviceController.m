//
//  DeviceController.m
//  scsi2sd
//
//  Created by Gregory Casamento on 12/3/18.
//  Copyright © 2018 Open Logic. All rights reserved.
//

#import "DeviceController.h"
#import "NSString+Extensions.h"

#include "ConfigUtil.h"
@interface DeviceController ()

@property IBOutlet NSButton *enableSCSITarget;
@property IBOutlet NSComboBox *SCSIID;
@property IBOutlet NSPopUpButton *deviceType;
@property IBOutlet NSTextField *sdCardStartSector;
@property IBOutlet NSTextField *sectorSize;
@property IBOutlet NSTextField *sectorCount;
@property IBOutlet NSTextField *deviceSize;
@property IBOutlet NSPopUpButton *deviceUnit;
@property IBOutlet NSTextField *vendor;
@property IBOutlet NSTextField *productId;
@property IBOutlet NSTextField *revsion;
@property IBOutlet NSTextField *serialNumber;
@property IBOutlet NSButton *autoStartSector;
@property IBOutlet NSTextField *sectorsPerTrack;
@property IBOutlet NSTextField *headsPerCylinder;

@property IBOutlet NSTextField *autoErrorText;
@property IBOutlet NSTextField *scsiIdErrorText;

@property BOOL duplicateId;
@property BOOL sectorOverlap;

@end

@implementation DeviceController

- (void) awakeFromNib
{
    self.enableSCSITarget.toolTip = @"Enable this device";
    self.SCSIID.toolTip = @"Unique SCSI ID for target device";
    self.deviceType.toolTip = @"Dervice type: HD, Removable, etc";
    self.sdCardStartSector.toolTip = @"Supports multiple SCSI targets";
    self.sectorSize.toolTip = @"Between 64 and 8192. Default of 512 is suitable in most cases.";
    self.sectorCount.toolTip = @"Number of sectors (device size)";
    self.deviceSize.toolTip = @"Device size";
    self.deviceUnit.toolTip = @"Units for device: GB, MB, etc";
    self.vendor.toolTip = @"SCSI Vendor string. eg. ' codesrc'";
    self.productId.toolTip = @"SCSI Product ID string. eg. 'SCSI2SD";
    self.revsion.toolTip = @"SCSI device revision string. eg. '3.5a'";
    self.serialNumber.toolTip = @"SCSI serial number. eg. '13eab5632a'";
    self.autoStartSector.toolTip = @"Auto start sector based on other targets";
    self.sectorsPerTrack.toolTip = @"Number of sectors in each track";
    self.headsPerCylinder.toolTip = @"Number of heads in cylinder";
    
    // Initial values
    self.autoErrorText.stringValue = @"";
    self.scsiIdErrorText.stringValue = @"";
}

- (NSData *) structToData: (S2S_TargetCfg)config withMutableData: (NSMutableData *)d
{
    [d appendBytes:&config length:sizeof(S2S_TargetCfg)];
    return [d copy];
}

- (NSData *) structToData: (S2S_TargetCfg)config
{
    return [self structToData:config withMutableData:[NSMutableData data]];
}

- (S2S_TargetCfg) dataToStruct: (NSData *)d
{
    S2S_TargetCfg config;
    memcpy(&config, [d bytes], sizeof(S2S_TargetCfg));
    return config;
}

- (void) setTargetConfig: (S2S_TargetCfg)config
{
    NSData *d = [self structToData:config];
    [self performSelectorOnMainThread:@selector(setTargetConfigData:)
                           withObject:d
                        waitUntilDone:YES];
}

- (void) setTargetConfigData: (NSData *)data
{
    S2S_TargetCfg config = [self dataToStruct: data];
    
    self.enableSCSITarget.state = (config.scsiId & S2S_CFG_TARGET_ENABLED) ? NSOnState : NSOffState;
    [self.SCSIID setStringValue:
     [NSString stringWithFormat: @"%d", (config.scsiId & S2S_CFG_TARGET_ID_BITS)]];
    [self.deviceType selectItemAtIndex: config.deviceType];
    [self.sdCardStartSector setStringValue:[NSString stringWithFormat:@"%d", config.sdSectorStart]];
    [self.sectorSize setStringValue: [NSString stringWithFormat: @"%d", config.bytesPerSector]];
    [self.sectorCount setStringValue: [NSString stringWithFormat: @"%d", config.scsiSectors]];
    [self.deviceSize setStringValue: [NSString stringWithFormat: @"%d", (((config.scsiSectors * config.bytesPerSector) / (1024 * 1024)) + 1) / 1024]];
    // Heads per cylinder is missing... should add it here.
    // Sectors per track...
    [self.vendor setStringValue: [NSString stringWithCString:config.vendor length:8]];
    [self.productId setStringValue: [NSString stringWithCString:config.prodId length:16]];
    [self.revsion setStringValue: [NSString stringWithCString:config.revision length:4]];
    [self.serialNumber setStringValue: [NSString stringWithCString:config.serial length:16]];
    [self.sectorsPerTrack setStringValue: [NSString stringWithFormat: @"%d", config.sectorsPerTrack]];
    [self.headsPerCylinder setStringValue: [NSString stringWithFormat: @"%d", config.headsPerCylinder]];
    // [self.autoStartSector setState:]
}

- (void) getTargetConfigData: (NSMutableData *)d
{
    S2S_TargetCfg targetConfig;
    
    targetConfig.scsiId = self.SCSIID.intValue & S2S_CFG_TARGET_ID_BITS;
    if (self.enableSCSITarget.state == NSOnState)
    {
        targetConfig.scsiId = targetConfig.scsiId | S2S_CFG_TARGET_ENABLED;
    }
    targetConfig.deviceType = self.deviceType.indexOfSelectedItem;
    targetConfig.sdSectorStart = self.sdCardStartSector.intValue;
    targetConfig.bytesPerSector = self.sectorSize.intValue;
    targetConfig.scsiSectors = self.sectorCount.intValue;
    targetConfig.headsPerCylinder = self.headsPerCylinder.intValue;
    targetConfig.sectorsPerTrack = self.sectorsPerTrack.intValue;
    strncpy(targetConfig.vendor, [self.vendor.stringValue cStringUsingEncoding:NSUTF8StringEncoding], 8);
    strncpy(targetConfig.prodId, [self.productId.stringValue cStringUsingEncoding:NSUTF8StringEncoding], 16);
    strncpy(targetConfig.revision, [self.revsion.stringValue cStringUsingEncoding:NSUTF8StringEncoding], 4);
    strncpy(targetConfig.serial, [self.serialNumber.stringValue cStringUsingEncoding:NSUTF8StringEncoding], 16);
    [self structToData: targetConfig withMutableData: d];
}

- (S2S_TargetCfg) getTargetConfig
{
    NSMutableData *d = [NSMutableData data];
    [self performSelectorOnMainThread:@selector(getTargetConfigData:)
                           withObject:d
                        waitUntilDone:YES];
    return  [self dataToStruct: d];
}

- (NSString *) toXml
{
    return [ConfigUtil targetCfgToXML: [self getTargetConfig]]; // [NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding];
}

- (BOOL) evaluate
{
    // NSLog(@"fromXml");
    return YES;
}

- (BOOL) isEnabled
{
    return self.enableSCSITarget.state == NSOnState;
}

- (NSUInteger) getSCSIId
{
    return (NSUInteger)self.SCSIID.integerValue;
}

- (void) setDuplicateID: (BOOL)flag
{
    self.duplicateId = flag;
    if(flag)
        self.scsiIdErrorText.stringValue = @"Duplicate IDs.";
    else
        self.scsiIdErrorText.stringValue = @"";
}
- (void) setSDSectorOverlap: (BOOL)flag
{
    self.sectorOverlap = flag;
    if(flag)
        self.autoErrorText.stringValue = @"Sectors overlap.";
    else
        self.autoErrorText.stringValue = @"";
}

- (NSRange) getSDSectorRange
{
    return NSMakeRange(self.sdCardStartSector.integerValue,
                       self.sectorCount.integerValue);
}

- (void) setAutoStartSectorValue: (NSUInteger)sector
{
    self.sdCardStartSector.integerValue = (NSInteger)sector;
}
@end
