//
//  IsNumericStringExtesion.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 03/10/21.
//


// Based on
//https://stackoverflow.com/questions/34587094/how-to-check-if-text-contains-only-numbers/34587234
extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
