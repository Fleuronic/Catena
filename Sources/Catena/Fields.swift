// Copyright © Fleuronic LLC. All rights reserved.

import protocol PersistDB.ModelProjection

public protocol Fields: PersistDB.ModelProjection, Decodable where Model: Catena.Model {}
