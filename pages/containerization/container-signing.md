---
last_updated: July 16, 2019 @ 12:21
tags:
- docker
- containerization
- signing
toc: true
series: ''
title: Container Signing
keywords: docker, signing, container
summary: DockerHub provides a lesser known feature for Container Image Signing via
  Notary, understand the practical and suitable use-cases of this technology over
  standard unsigned containers.
permalink: containerization-signing.html
folder: containerization
datatable: false
published: false

---
## Situational Awareness

As technology re-invents itself in the ether, we re-encounter situations that previously well-working solutions were provided for. One such situation is Signing of Containers.

### Concept

Signing of work has been around for eons. Artists sign their crafter masterpieces, and developers using any version control system attach their name on each commit. We _trust_ these names as we have not been given a reson not to. Unfortunately _trust_ can often be misplaced and explioted with melicious actors. 

This previntion of exploitation requires proof that the person who claims to have authored something now proove undeniably that their work is indeed their own and not anothers masquerading as theirs. In CyberSpace we use GnuPG keys (or alternative key implementation) to sign code commits. A process that is rapidly becoming more mandatory than optional for developers due to the sensitivity of Personally Identifiable Information (PII) and PCI regulations.

### Extending Signing to Containers

If individual code commits are capable of being signed against a person, then shouldn't the aggregation of code be signed against a team, and each piece of the operating system signed to form a complete picture?

The aforementioned question instantly shows the challenges in sucessful signing. The very concept requires that everything be atomically signed so the aggregated piece can be signed. Granted some Linux systems are trying to move this way, but only for core functionality as the thousands of individual components of often unsigned or haven't needed to be updated as they are trusted for years.

Containers being operating systems running within a host operating system introduce an interesting complexity to the equation. As they are a snapshot in time, can't we just sign this snapshot as secure and move on. Unfortunately not, as again all parts of the tree assembling the container may not be signed, or trusted. This doesn't mean we shouldn't sign containers, just to understand we cannot assume just because something is signed it should be trusted. [Container Certificaton] exists for the very reason of building trust that the image is safe.

## Approach to Signing Containers

Signing Containers, or what is also called _Content Trust_ is not supported by all Container Image Repositories, and for good reason. Its hard to implement with the only successful trust implementation being [Notary](#Notary) via _The Update Framework_. Its also risky. Root keys must be generated, and repository independent keys and user delegations managed carefully. A mistake, and Notary will lock out the repository name from trust.

There's also the small matter of _hashing_. Most humans are comfortable grabbing the latest image via a known standard such as [SemVer](https://semver.org/) but comparing hashes for container versions against timestamps to know which is the latest is challenging and problematic for late night workers.

Finally repositories must be created and signed appropriated before images can be pushed to them (working against most CI workflows for new applications)

These risks and complexities don't offset the benefits of security or verifying the container is exactly the one you wanted. They just paint a picture as to why _Container Signing_ is slow on the uptake.

The final influencing factor is the generic assumption that all containers are the same, or built with a common purpose. In point of fact, they aren't. While the vast majority of containers are built for applications, Many exist as supporting Operating System Services.

### Application vs Operating System Containers

- **Application Containers**: are what developers are familiar with, write some code following a (hopefully) MicroService specification, push it through a Continous Integration (CI) pipeline and bundle into a Container that will run anywhere.
- **Operating System Containers**: provide dedicated services for assembling a Host Operating System to run, well, containers. [LinuxKit](https://github.com/linuxkit/linuxkit) is an excellent example of using Operating System Containers. 

There's a significant degree of trust difference between the two situations. While Applications are assumed and often verified as secure and safe, Operating Systems are **expected** to be safe and trusted.

### When to Sign Containers

Spefically when used in the assembly of Operating Systems, for all other situations Container Signing adds a lot of overhead for very little benefit over Code Signing. Again [Container Certification] should be pursued instead of Signing for Application Containers to promote trust and safety in images.

### Supporting Services

- [**Harbor**](https://goharbor.io/docs/): self hosted, Kubernetes compatible solution
- [**DockerHub**](https://hub.docker.com/): cloud based, largest container repository in existance

## Notary Survival Guide

> **Definition**: Notary is a tool for publishing and managing trusted collections of content. Publishers can digitally sign collections and consumers can verify integrity and origin of content. This ability is built on a straightforward key management and signing interface to create signed collections and configure trusted publishers.
>
> With Notary anyone can provide trust over arbitrary collections of data. Using The Update Framework (TUF) as the underlying security framework, Notary takes care of the operations necessary to create, manage, and distribute the metadata necessary to ensure the integrity and freshness of your content. [Docker's Notary Explanation](https://docs.docker.com/notary/getting_started/)


```sh

```