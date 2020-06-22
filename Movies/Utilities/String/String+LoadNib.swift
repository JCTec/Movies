//
//  String+LoadNib.swift
//  Movies
//
//  Created by Juan Carlos on 21/06/20.
//  Copyright © 2020 JCTechnologies. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    /// Carga un Archivo Nib con el nombre de la cadena de texto.
    ///
    /// - Parameter bundle: Bundle a agregar.
    /// - Returns: UINib.
    func loadNib(bundle: Bundle? = nil) -> UINib? {
        return UINib(nibName: self, bundle: bundle)
    }
}
