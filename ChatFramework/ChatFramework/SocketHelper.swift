//
//  SocketHelper.swift
//  Companion
//
//  Created by Ambu Sangoli on 28/09/22.
//

import Foundation
import SocketIO

public class SocketHelper {

    public static let shared = SocketHelper()
    public var socket: SocketIOClient!

    let manager = SocketManager(socketURL: URL(string: "wss://safechecksignalling.azurewebsites.net/")!, config: [.log(true), .compress])

    private init() {
        socket = manager.defaultSocket
    }

    public func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }

    public func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }

    public func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false

    }

    public enum Events {

        case event
        case server_initiated_event
        case joinRoom
        case allUsers
        case signal
        case sending_signal
        case receiving_returned_signal
        case disconnect_me_from_connections

        var emitterName: String {
            switch self {
            case .event:
                return "event"
            case .server_initiated_event:
                return "server-initiated-event"
            case .joinRoom:
                return "join room"
            case .allUsers:
                return "all users"
            case .signal:
                return "signal"
            case .sending_signal:
                return "sending signal"
            case .receiving_returned_signal:
                return "receiving returned signal"
            case .disconnect_me_from_connections:
                return "disconnect-me-from-connections"
            }
        }

        var listnerName: String {
            switch self {
            case .event:
                return "event"
            case .server_initiated_event:
                return "server-initiated-event"
            case .joinRoom:
                return "join room"
            case .allUsers:
                return "all users"
            case .signal:
                return "signal"
            case .sending_signal:
                return "sending signal"
            case .receiving_returned_signal:
                return "receiving returned signal"
            case .disconnect_me_from_connections:
                return "disconnect-me-from-connections"
            }
        }

        public func emit(params: String) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }

        public func emitJSON(params: [String:Any]) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }
        
        public func emitData(params: Data) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }
        
        public func listen(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }

        public func off() {
            SocketHelper.shared.socket.off(listnerName)
        }
    }
}
