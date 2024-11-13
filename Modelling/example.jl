# This is an example to use Modelling module


#-----------------------------------------------------------------
#example 1
#In this example;
#we will consider a simple unstructured community where uptake and leakage values are randomly drawn from a dirchlet distribution
#and all other parameters are set to 1
#-----------------------------------------------------------------
#=
include("./MiCRM.jl")
using .MiCRM
using DifferentialEquations
using Distributions

#set system size and leakage
N,M,leakage = 10,10,0.3

#uptake
du = Distributions.Dirichlet(N,1.0)
u = copy(rand(du, M)')

#cost term
m = ones(N)

#inflow + outflow
ρ,ω = ones(M),ones(M)

#leakage
l = copy(rand(du,M)' .* leakage)

param = (N = N, M = M, u = u, m = m, ρ = ρ, ω = ω, l = l, λ = leakage)
=#



#-----------------------------------------------------------------
#example 2
#In practice it is much more convenient to wrap this in a function. 
#In MiCRM.jl this is all wrapped in the generate_params function. 
#This function takes various functions as arguments which define how the parameters in the model are generated.
#By default generate_params creates communities with random parameters as above. 
#-----------------------------------------------------------------
#=
include("./MiCRM.jl")
using .MiCRM
using DifferentialEquations


#set system size and leakage
N,M,leakage = 10,10,0.3

#generate community parameters
param = MiCRM.Parameters.generate_params(N,M;λ = leakage)
=#









#Solve the ODE
#-----------------------------------------------------------------
#inital state
x0 = ones(N+M)
#time span
tspan = (0.0, 10.0)

#define problem
prob = ODEProblem(MiCRM.Simulations.dx!, x0, tspan, param)
sol = solve(prob, Tsit5())
#-----------------------------------------------------------------


