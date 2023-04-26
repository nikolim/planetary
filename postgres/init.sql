create table repositories
(
    id           varchar(255) unique not null,
    name         varchar(255)        not null,
    owner        varchar(255),
    platform     varchar(255)        not null,
    platform_tag varchar(255)        not null,
    collection   varchar(255),
    project      varchar(255),
    last_crawl   timestamp,
    primary key (id)
);

create table workflows
(
    id            varchar(255) unique not null,
    repository_id varchar(255)        not null,
    name          varchar(255)        not null,
    path          varchar(255),
    state         varchar(255),
    updated_at    timestamp           not null,
    created_at    timestamp           not null,
    foreign key (repository_id) references repositories (id),
    primary key (id)
);

create table runs
(
    id            varchar(255) unique not null,
    name          varchar(255)        not null,
    run_number    varchar(255)        not null,
    head_branch   varchar(255),
    head_sha      varchar(255),
    workflow_id   varchar(255),
    repository_id varchar(255),
    started_at    timestamp,
    queue_at      timestamp,
    finished_at   timestamp,
    foreign key (workflow_id) references workflows (id),
    primary key (id)
);

create table runners
(
    id         varchar(255) unique not null,
    name       varchar(255)        not null,
    group_id   int,
    group_name varchar(255),
    primary key (id)
);

create table jobs
(
    id         varchar(255) unique not null,
    name       varchar(255)        not null,
    start_time timestamp           not null,
    end_time   timestamp,
    runner     varchar(255)        not null,
    run_id     varchar(255),
    conclusion varchar(255),
    foreign key (runner) references runners (id),
    foreign key (run_id) references runs (id),
    primary key (id)
);

create table steps
(
    id         varchar(255) unique not null,
    name       varchar(255)        not null,
    start_time timestamp           not null,
    end_time   timestamp,
    job_id     varchar(255)        not null,
    conclusion varchar(255),
    --     foreign key (job_id) references jobs (id),
    primary key (id)
);

create table hosts
(
    name        varchar(255) not null,
    vsphere     varchar(255),
    cpu_model   varchar(255),
    cpu_cores   int,
    cpu_threads int,
    memory      bigint,
    vendor      varchar(255),
    model       varchar(255),
    primary key (name)
);

create table vms
(
    name             varchar(255) not null,
    num_cpu          int,
    memory           int,
    operating_system varchar(255),
    host_name        varchar(255),
    primary key (name),
    foreign key (host_name) references hosts (name)
);

