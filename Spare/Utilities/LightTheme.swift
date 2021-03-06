//
//  LightTheme.swift
//  Spare
//
//  Created by Matt Quiros on 09/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

struct LightTheme: Theme {
    
    func color(for element: ColoredElement) -> UIColor {
        switch element {
        case .barTint,
             .cellAccessoryRefresh,
             .controlTint,
             .regularText:
            return UIColor.black
            
        case .cellAccessoryClear:
            return .hex(0xff6565)
            
        case .sectionTotalHeaderViewBackground,
             .filterButtonBackground:
            return UIColor.hex(0x666666)
            
        case .groupedTableViewSectionHeader,
             .groupedTableViewSectionFooter,
             .promptLabel:
            return UIColor.hex(0x999999)
            
        case .disclosureIndicator,
             .tableViewSeparator:
            return UIColor.hex(0xdddddd)
            
        case .fieldIcon,
             .placeholder:
            return UIColor.hex(0xbbbbbb)
            
        case .barBackground,
             .sectionTotalHeaderViewText,
             .filterButtonContent,
             .mainBackground:
            return UIColor.white
        }
    }
    
    func font(for element: StringElement) -> UIFont {
        switch element {
        case .dateTextFieldLabel:
//            return NotoSansUI.regular(10)
            return .systemFont(ofSize: 10)
            
        case .cellSecondaryText,
             .sectionTotalHeaderView,
             .filterButtonText,
             .groupedTableViewSectionHeader,
             .groupedTableViewSectionFooter:
//            return NotoSansUI.regular(14)
            return .systemFont(ofSize: 12)
            
        case .loadableViewInfoLabelMainText:
//            return NotoSansUI.regular(24)
            return .systemFont(ofSize: 24)
            
        case .loadableViewInfoLabelSecondaryText:
//            return NotoSansUI.regular(15)
            return .systemFont(ofSize: 15)
            
        case .navBarTitle:
//            return NotoSansUI.bold(17)
            return .boldSystemFont(ofSize: 17)
            
        case .regularText:
//            return NotoSansUI.regular(17)
            return .systemFont(ofSize: 17)
        }
    }
    
}
