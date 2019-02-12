# singularity-ppc64-tools
A set of tools to create and run Singularity containers on ppc64 systems

# Overview

With the venue of PPC64 platforms such as Summit at ORNL, the interest for running containers on such machines is clearly increasing. I assume here that the target PPC64 platform has the same constraints than most high-performance computing systems:
- root access is not available on the computing platform,
- the target applications are mainly MPI simulations.

# Why Singularity?

If you wonder why i chose Singularity, it is simple: it is, i think, the best container technology that does require root access on the computing system. However, it is not without additional challenges that will be covered later in this document and by the tools in this repository.

This repostory therefore gathers all my notes, thoughts and scripts i used to achieve my goal of running Singularity containers on a PPC64-based high-performance computing platform.

# Architecture

## Image creation

Before running container, we must create a Singularity image. And this is where the real challenges start since most computing centers do not (yet) provide build service for the target platform. So how can i create a PPC64 Singularity image, which requires the execution of privileged commands, without having a privileged access to the target computing platform? In addition, i clearly do not have a PPC64 system at home. My solution? Full emulation with QEMU.

Once the image created, it is possible to copy it onto the target platform.

## Container execution

Because we target MPI simulations, we need to start Singularity containers on the compute nodes and run the MPI simulation inside the container.
