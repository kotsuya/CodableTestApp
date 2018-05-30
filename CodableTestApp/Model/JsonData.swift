//
//  JsonData.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/30.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import Foundation

struct JsonItemsLicense: Codable {
    let key: String
    let name: String
    let spdx_id: String?
    let url: URL?
}

struct JsonItemsOwner: Codable {
    let login: String
    let id: Int
    let avatar_url: URL
    let gravatar_id: String?
    let url: URL
    let html_url: URL
    let followers_url: URL
    let following_url: String?
    let gists_url: String
    let starred_url: String
    let subscriptions_url: URL
    let organizations_url: URL
    let repos_url: URL
    let events_url: String
    let received_events_url: URL
    let type: String
    let site_admin: Bool
}

struct JsonItems: Codable {
    let id: Int
    let name: String
    let full_name: String
    let owner: JsonItemsOwner
    let `private`: Bool
    let html_url: URL
    let description: String
    let fork: Bool
    let url: URL
    let forks_url: URL
    let keys_url: String
    let collaborators_url: String
    let teams_url: URL
    let hooks_url: URL
    let issue_events_url: String
    let events_url: URL
    let assignees_url: String
    let branches_url: String
    let tags_url: URL
    let blobs_url: String
    let git_tags_url: String
    let git_refs_url: String
    let trees_url: String
    let statuses_url: String
    let languages_url: URL
    let stargazers_url: URL
    let contributors_url: URL
    let subscribers_url: URL
    let subscription_url: URL
    let commits_url: String
    let git_commits_url: String
    let comments_url: String
    let issue_comment_url: String
    let contents_url: String
    let compare_url: String
    let merges_url: URL
    let archive_url: String
    let downloads_url: URL
    let issues_url: String
    let pulls_url: String
    let milestones_url: String
    let notifications_url: String
    let labels_url: String
    let releases_url: String
    let deployments_url: URL
    let created_at: String
    let updated_at: String
    let pushed_at: String
    let git_url: URL
    let ssh_url: URL
    let clone_url: URL
    let svn_url: URL
    let homepage: String?
    let size: Int
    let stargazers_count: Int
    let watchers_count: Int
    let language: String
    let has_issues: Bool
    let has_projects: Bool
    let has_downloads: Bool
    let has_wiki: Bool
    let has_pages: Bool
    let forks_count: Int
    let mirror_url: URL?
    let archived: Bool
    let open_issues_count: Int
    let license: JsonItemsLicense?
    let forks: Int
    let open_issues: Int
    let watchers: Int
    let default_branch: String
    let score: Int
}

struct JsonData: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [JsonItems]
}


