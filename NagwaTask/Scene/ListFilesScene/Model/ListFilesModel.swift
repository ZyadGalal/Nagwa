//
//  ListFilesModel.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import Foundation

struct FileModel {
    let fileName: String
    let path: URL
    let fileType: FileType
    let duration: String
}

enum FileType {
    case Folder, Audio
}
