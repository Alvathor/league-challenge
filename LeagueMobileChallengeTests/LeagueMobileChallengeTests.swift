//
//  LeagueMobileChallengeTests.swift
//  LeagueMobileChallengeTests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest
import Combine
@testable import LeagueMobileChallenge

class LeagueMobileChallengeTests: XCTestCase {

    private var postService: PostServiceProtocol!
    private var userService: UserServiceProtocol!
    private var cancellables: Set<AnyCancellable> = []
    private var user: User!
    private var userEmpty: User!
    
    override func setUp() {
        postService = MockedPostService()
        userService = MockedUserService()
        user = User(id: 1, avatar: nil, username: "user1")
        userEmpty = User(id: 0, avatar: nil, username: "")
    }
    
    // MARK: - FetchUser
    
    func testFetchUserSuccess() {
        let expectation = XCTestExpectation()
        userService
            .getUsers()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNil(error)
                }
            }, receiveValue: { users in
                XCTAssertTrue(!users.isEmpty)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    // MARK: - FetchPost
    
    func testFetchPostFailureWithoutUser() {
        let expectation = XCTestExpectation()
        postService
            .getPosts(from: userEmpty)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNotNil(error)
                }
            }, receiveValue: { posts in
                XCTAssertTrue(posts.isEmpty)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchPostSuccess() {
        let expectation = XCTestExpectation()
        postService
            .getPosts(from: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNil(error)
                }
            }, receiveValue: { posts in
                XCTAssertTrue(!posts.isEmpty)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - FetchAdditionalUser
    
    func testFetchAdditionalUserSuccess() {
        let expectation = XCTestExpectation()
        userService
            .getUsers()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNil(error)
                }
            }, receiveValue: { users in
                XCTAssertTrue(!users.isEmpty)
                XCTAssertNotNil(users.first?.id)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    // MARK: - FetchAdditionalPost
    
    func testFetchAdditionalPostSuccess() {
        let expectation = XCTestExpectation()
        postService
            .getPosts(from: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNil(error)
                }
            }, receiveValue: { posts in
                XCTAssertTrue(!posts.isEmpty)
                XCTAssertNotNil(posts.first?.id)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
}
